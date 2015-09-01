#=
- Deterministic Rule
- Compute Detection and Falsealarm without care threshold

- Example

Assume
-Quality goal (a, b) = (0.05, 0.95)
-Type A sensor = (0.1, 0.9)
-Type B sensor = (0.4, 0.6)

We already have 5 type1 sensor, Under this condition, how many number of type2 sensor we need?
This question can be solve by thie function

Ans:
5 numberA(0.1 ,0.9) + 20 sensorB(0.4, 0.6) => (0.0424, 0.9576)

- last change:
=#

function det_fusiontwotype(NumofFix, FalseofTarget, DetectofTarget, FalseofFix, DetectofFix, FalseofMove, DetectofMove )

  max_testnumber = 250

  for NumofMove = 0: max_testnumber  #Find Number of Move

    sensor_total = NumofFix + NumofMove
    sensor_buffer = zeros(2, sensor_total)

    for quality_in = 1 : NumofFix    # input sensor quality in work buffer

      sensor_buffer[1, quality_in] = DetectofFix
      sensor_buffer[2, quality_in] = FalseofFix

    end

    for quality_in = (NumofFix + 1) : sensor_total   # input sensor quality in work buffer

      sensor_buffer[1, quality_in] = DetectofMove
      sensor_buffer[2, quality_in] = FalseofMove

    end

    probability_buffer = zeros(4, sensor_total)  #Use to compute probability of senor-fix and sensor-move



  end  #first loop: for

end  #function























#= Matlab code
function [NumberofTypeMove, detecetion, falsealarm, thresholdTofF ] = DissimilarSensorFusion(NumberofTypeFix,Goal_F,Goal_D,TypeFixOfFalse,TypeFixOfDetection,TypeMoveOfFalse,TypeMoveOfDetection)

warning off

%function[detecetion,falsealarm]=DissimilarSensorFusion(NumberofTypeFix, Goal_F, Goal_D, TypeFixOfFalse, TypeFixOfDetection, TypeMoveOfFalse, TypeMoveOfDetection)
%Deterministic Rule
MaxFindNumber = 200;

for NumberofTypeMove = 0 : MaxFindNumber
    NumberOfALL = (NumberofTypeFix+NumberofTypeMove);

    WorkBuffer = zeros(2,NumberOfALL);

    % for i = 1:NumberOfSS
    %
    %     aa(1,i) = i;
    %     ee(1,i) = i;
    %
    % end

    for i = 1:NumberofTypeFix
        WorkBuffer(1,i) = TypeFixOfDetection;
        WorkBuffer(2,i) = TypeFixOfFalse;
    end

    for j = (NumberofTypeFix+1):NumberOfALL
        WorkBuffer(1,j) = TypeMoveOfDetection;
        WorkBuffer(2,j) = TypeMoveOfFalse;
    end

    WorkBuffer;
    ComputeBuffer = zeros(4,NumberOfALL);

    for i = 1:NumberofTypeFix
        ComputeBuffer(1,i) = nchoosek(1,0)*((TypeFixOfDetection)^0)*((1-TypeFixOfDetection)^(1));
        ComputeBuffer(2,i) = nchoosek(1,1)*((TypeFixOfDetection)^1)*((1-TypeFixOfDetection)^(0));
        ComputeBuffer(3,i) = nchoosek(1,0)*((TypeFixOfFalse)^0)*((1-TypeFixOfFalse)^(1));
        ComputeBuffer(4,i) = nchoosek(1,1)*((TypeFixOfFalse)^1)*((1-TypeFixOfFalse)^(0));
    end

    for i = (NumberofTypeFix+1):NumberOfALL
        ComputeBuffer(1,i) = nchoosek(1,0)*((TypeMoveOfDetection)^0)*((1-TypeMoveOfDetection)^(1));
        ComputeBuffer(2,i) = nchoosek(1,1)*((TypeMoveOfDetection)^1)*((1-TypeMoveOfDetection)^(0));
        ComputeBuffer(3,i) = nchoosek(1,0)*((TypeMoveOfFalse)^0)*((1-TypeMoveOfFalse)^(1));
        ComputeBuffer(4,i) = nchoosek(1,1)*((TypeMoveOfFalse)^1)*((1-TypeMoveOfFalse)^(0));
    end

    ComputeBuffer;

    for i = 0:NumberOfALL  % Watch out the ( 0:NumberOfSS )
        egg = (NumberOfALL - i);
        buffer_sum_b = 0;

        for j = egg:NumberOfALL

            buffer_sum_a = 0;

            for k = 0:j
                buffer_a = (j - k);
                buffer_b = (j - buffer_a);

                if buffer_a > NumberofTypeMove | buffer_b > NumberofTypeFix
                    continue
                else
                    buffer_c = (nchoosek(NumberofTypeMove,buffer_a) * ((TypeMoveOfFalse)^buffer_a) * ((1 - TypeMoveOfFalse)^(NumberofTypeMove-buffer_a))) * ...
                        (nchoosek(NumberofTypeFix,buffer_b) * ((TypeFixOfFalse)^buffer_b) * ((1 - TypeFixOfFalse)^(NumberofTypeFix-buffer_b))) ;
                    buffer_sum_a = buffer_sum_a + buffer_c ;
                end
            end

            buffer_sum_b = buffer_sum_b + buffer_sum_a;

        end

        if buffer_sum_b >= Goal_F
            thresholdTofF = egg+1 ;
            buffer_sum_b;
            break
        end

    end

    buffer_sum_b = 0; % re initial
    buffer_sum_e = 0;

    for j = thresholdTofF:NumberOfALL

        buffer_sum_a = 0;
        buffer_sum_d = 0;
        for k = 0:j
            buffer_a = (j - k);
            buffer_b = (j - buffer_a);

            if buffer_a > NumberofTypeMove | buffer_b > NumberofTypeFix
                continue
            else
                buffer_c = (nchoosek(NumberofTypeMove,buffer_a) * ((TypeMoveOfFalse)^buffer_a) * ((1 - TypeMoveOfFalse)^(NumberofTypeMove-buffer_a))) * ...
                    (nchoosek(NumberofTypeFix,buffer_b) * ((TypeFixOfFalse)^buffer_b) * ((1 - TypeFixOfFalse)^(NumberofTypeFix-buffer_b))) ;
                buffer_sum_a = buffer_sum_a + buffer_c ;

                buffer_f = (nchoosek(NumberofTypeMove,buffer_a) * ((TypeMoveOfDetection)^buffer_a) * ((1 - TypeMoveOfDetection)^(NumberofTypeMove-buffer_a))) * ...
                    (nchoosek(NumberofTypeFix,buffer_b) * ((TypeFixOfDetection)^buffer_b) * ((1 - TypeFixOfDetection)^(NumberofTypeFix-buffer_b))) ;
                buffer_sum_d = buffer_sum_d + buffer_f ;

            end
        end

        buffer_sum_b = buffer_sum_b + buffer_sum_a;
        buffer_sum_e = buffer_sum_e + buffer_sum_d;
    end

    falsealarm = buffer_sum_b;
    detecetion = buffer_sum_e;

    if detecetion >= Goal_D &&  falsealarm <= Goal_F && NumberofTypeMove ==0
        fprintf(1,'NumberofTypeMove is %3.2f ; detecetion is %3.6f ; falsealarm is %3.6f',NumberofTypeMove, detecetion, falsealarm );
        fprintf('\n');
        fprintf('\n');
        break
    end

    if detecetion >= Goal_D &&  falsealarm <= Goal_F && NumberofTypeMove ~=0
        NumberofTypeMove;
        [detecetion falsealarm];
        break
    end

end

end


=#
