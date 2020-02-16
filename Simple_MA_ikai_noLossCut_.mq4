//--------------------------------------------------------------------

//�v���p�e�B�A�ݒ�
#property  copyright "Copyright 2010 Toushituu Corporation"
#property  link "http://mt4-ea.jp"
extern double	pLots = 1;				//���b�g��
extern int		pSlipPage = 3;			//�X���b�v�y�[�W�̍ő吔�iPips�j
extern int		pMagicNumber = 39974;	//�}�W�b�N�i���o�[

//�p�����[�^�[

extern int		pMALongExp = 20;
extern int		pMAShortExp = 5;










//�o�b�t�@

double		gBuffer0Long[256];
double		gBuffer0Short[256];


//�O���[�o���ϐ�
int			gPreviousBar = 0;
int			gLastBuyBar = 0;
int			gLastSellBar = 0;

//--------------------------------------------------------------------

//�V�����o�[������邽�тɌĂяo�����֐�
int start()
{
	int			startNo, countedNum, i, i2, myInt, myInt2, myInt3, buyFlag, sellFlag;
	bool		myBool1, myBool2, myBool3;
	double		myDouble, myDouble1, myDouble2, myDouble3, myDouble4, myDouble5, myStop, myLimit, myArray[];
	
	//--------------------------------------------------------------------
	// ������
	//--------------------------------------------------------------------
	
	//�ω����ĂȂ��o�[�̐�����A�X�V���ׂ��J�o�[�̐����v�Z
	startNo = Bars - gPreviousBar;
	if( Bars == startNo ) startNo = Bars - 1;
	
	//�o�[���������̂Ȃ�
	if( gPreviousBar != Bars ){
	//�z������T�C�Y

		ArrayCopy( myArray, gBuffer0Long );
		//ArrayResize( gBuffer0Long, Bars );
		ArrayCopy( gBuffer0Long, myArray, startNo, 0, 255 - startNo );
		ArrayCopy( myArray, gBuffer0Short );
		//ArrayResize( gBuffer0Short, Bars );
		ArrayCopy( gBuffer0Short, myArray, startNo, 0, 255 - startNo );

	}
	
	//--------------------------------------------------------------------
	// ����
	//--------------------------------------------------------------------
	

	

	

	
	//--------------------------------------------------------------------
	// �f�[�^���v�Z
	//--------------------------------------------------------------------
	
	//�X�V���ׂ��o�[�̐��������[�v
	for( i = startNo; 0 <= i; i-- ){

		//--------------------�ړ����ϐ�--------------------
		gBuffer0Long[i] = iMA( NULL, 0, pMALongExp, 0, MODE_SMA, PRICE_CLOSE, i );
		gBuffer0Short[i] = iMA( NULL, 0, pMAShortExp, 0, MODE_SMA, PRICE_CLOSE, i );

	}
	
	//--------------------------------------------------------------------
	// ���ρ������I��
	//--------------------------------------------------------------------
	

	

	

	

	
	//�V�����o�[�̐����L�^
	gPreviousBar = Bars;
	
	//--------------------------------------------------------------------
	// ���������`�F�b�N
	//--------------------------------------------------------------------
	
	//������
	buyFlag = 0;
	sellFlag = 0;
	

	//--------------------�ړ����ϐ�--------------------

	//�Z���������������㔲������/�����Ă����甃��
	if( gBuffer0Long[0] < gBuffer0Short[0] && gBuffer0Short[1] <= gBuffer0Long[1] ){
		if( buyFlag == 0 ) buyFlag = 1;
	} else {
		buyFlag = -1;
	}

	//�Z������������������������/������Ă����甄��
	if( gBuffer0Short[0] < gBuffer0Long[0] && gBuffer0Long[1] <= gBuffer0Short[1] ){
		if( sellFlag == 0 ) sellFlag = 1;
	} else {
		sellFlag = -1;
	}


	
	//--------------------------------------------------------------------
	// ����
	//--------------------------------------------------------------------
	
	//���������ɂȂ��āA�ȑO���������Ƃ�����o�[�����ς���Ă���̂Ȃ�
	if( buyFlag == 1 && gLastBuyBar != Bars ){
		//�o�[�����L�^
		gLastBuyBar = Bars;
		

		//���蒍�����c���Ă�̂Ȃ猈��
		MyClose( OP_SELL, pLots, pSlipPage, pMagicNumber ); 

		
		//----------���؂�Ɨ��H�����v�Z----------
		//������
		myStop = 0;
		myLimit = 0;
		myDouble1 = 0;
		myDouble2 = 0;
		myDouble3 = 0;
		myDouble4 = 0;
		
		//���[�g�ϓ��i���j�ŗ��H���^���؂�

		
		//���[�g�ϓ��iPips�j�ŗ��H���A���؂�

		
		//���Ⴂ���H���A��荂�����؂�ɐݒ�
		if( myDouble1 != 0 ){
			if( myDouble3 != 0 ){
				if( myDouble1 <= myDouble3 ) myLimit = myDouble1;
				else myLimit = myDouble3;
			} else {
				myLimit = myDouble1;
			}
		} else {
			if( myDouble3 != 0 ){
				myLimit = myDouble3;
			}
		}
		if( myDouble2 != 0 ){
			if( myDouble4 != 0 ){
				if( myDouble4 <= myDouble2 ) myStop = myDouble2;
				else myStop = myDouble4;
			} else {
				myStop = myDouble2;
			}
		} else {
			if( myDouble4 != 0 ){
				myStop = myDouble4;
			}
		}
		
		//���������𑗐M
		MyOrder( OP_BUY, pLots, pSlipPage, myStop, myLimit, pMagicNumber, 0 );
	}
	
	//���蒍���ɂȂ��āA�ȑO���������Ƃ�����o�[�����ς���Ă���̂Ȃ�
	if( sellFlag == 1 && gLastSellBar != Bars ){
		//�o�[�����L�^
		gLastSellBar = Bars;
		

		//�����������c���Ă�̂Ȃ猈��
		MyClose( OP_BUY, pLots, pSlipPage, pMagicNumber ); 

		
		//----------���؂�Ɨ��H�����v�Z----------
		//������
		myStop = 0;
		myLimit = 0;
		myDouble1 = 0;
		myDouble2 = 0;
		myDouble3 = 0;
		myDouble4 = 0;
		
		//���[�g�ϓ��i���j�ŗ��H���^���؂�

		
		//���[�g�ϓ��iPips�j�ŗ��H���A���؂�

		
		//��荂�����H���A���Ⴂ���؂�ɐݒ�
		if( myDouble1 != 0 ){
			if( myDouble3 != 0 ){
				if( myDouble3 <= myDouble1 ) myLimit = myDouble1;
				else myLimit = myDouble3;
			} else {
				myLimit = myDouble1;
			}
		} else {
			if( myDouble3 != 0 ){
				myLimit = myDouble3;
			}
		}
		if( myDouble2 != 0 ){
			if( myDouble4 != 0 ){
				if( myDouble2 <= myDouble4 ) myStop = myDouble2;
				else myStop = myDouble4;
			} else {
				myStop = myDouble2;
			}
		} else {
			if( myDouble4 != 0 ){
				myStop = myDouble4;
			}
		}
		
		//���蒍���𑗐M
		MyOrder( OP_SELL, pLots, pSlipPage, myStop, myLimit, pMagicNumber, 0 );
	}
	
	return(0);
}

//--------------------------------------------------------------------

//��������
int MyOrder( int ordType, double lot, int slipPage, double stopLoss, double profit, int magicNumber, double expBarNum )
{
	int			i, ticket = -1;
	double		stopLossMin, stopLoss2, profit2;
	datetime	expDateTime = 0;
	
	//�L�������̃o�[������������v�Z����
	if( 0 < expBarNum ) expDateTime = TimeCurrent() + (Period() * expBarNum * 60);
	
	//�X�g�b�v���X���ŏ��ȉ����ǂ����`�F�b�N
	//if( stopLoss != 0 ){
	//	stopLossMin = MarketInfo(Symbol(),MODE_STOPLEVEL);
	//	if( stopLoss < stopLossMin ) stopLoss = stopLossMin;
	//}
	
	//���������肩�ŕ���
	if ( ordType == OP_BUY ){
		//���������𑗐M
		ticket = OrderSend( Symbol(), OP_BUY, lot, Ask, slipPage, stopLoss, profit, NULL, magicNumber, expDateTime, Blue );
		if( ticket == -1 ){
			Print( "OrderSend error = ", GetLastError());
			return ( -1 );
		} else {
			//OrderSelect( ticket, SELECT_BY_TICKET );
			//OrderModify( ticket, OrderOpenPrice(), stopLoss, profit, 0, Blue );		
		}
	} else if ( ordType == OP_SELL ){
		//���蒍���𑗐M
		ticket = OrderSend( Symbol(), OP_SELL, lot, Bid, slipPage, stopLoss, profit, NULL, magicNumber, expDateTime, Red );
		if( ticket == -1 ){
			Print( "OrderSend error = ", GetLastError());
			return ( -1 );
		} else {
			//OrderSelect( ticket, SELECT_BY_TICKET );
			//OrderModify( ticket, OrderOpenPrice(), stopLoss, profit, 0, Red );		
		}
	}
	
	return(0);
}

//--------------------------------------------------------------------

//���Ϗ���
int MyClose( int ordType, double lots, int slipPage, int magicNumber )
{
	int		i, ticket = -1;
	bool	result;
	
	//�����̐��������[�v
	for( i = OrdersTotal() - 1; 0 <= i; i-- ){
		//���ς��I����ĂȂ��̂Ȃ�A�I��
		if( OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == true ){
			//�y�A��ނƃ}�W�b�N�i���o�[����v���Ă�����
			if( OrderSymbol() == Symbol() && ( magicNumber == 0 || OrderMagicNumber() == magicNumber )) {
				//�w�肳�ꂽ�����Ȃ�
				if( ordType == -1 || OrderType() == ordType ){
					//���̃`�P�b�gNo���擾
					ticket = OrderTicket();
					
					//����������
					if ( OrderType() == OP_BUY ) result = OrderClose( ticket, lots, Bid, slipPage );
					else if ( OrderType() == OP_SELL ) result = OrderClose( ticket, lots, Ask, slipPage );
					else result = OrderDelete( ticket );
					
					//���ʂ��G���[�Ȃ�\��
					if ( result == False ){
						Print( "OrderClose error = ", GetLastError());
						//return ( -1 );
					}
				}
			}
		}
	}
	
	return( 0 );
}

//--------------------------------------------------------------------
