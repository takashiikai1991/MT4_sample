//--------------------------------------------------------------------

//プロパティ、設定
#property  copyright "Copyright 2010 Toushituu Corporation"
#property  link "http://mt4-ea.jp"
extern double	pLots = 1;				//ロット数
extern int		pSlipPage = 3;			//スリップページの最大数（Pips）
extern int		pMagicNumber = 39974;	//マジックナンバー

//パラメーター

extern int		pMALongExp = 20;
extern int		pMAShortExp = 5;










//バッファ

double		gBuffer0Long[256];
double		gBuffer0Short[256];


//グローバル変数
int			gPreviousBar = 0;
int			gLastBuyBar = 0;
int			gLastSellBar = 0;

//--------------------------------------------------------------------

//新しいバーが現れるたびに呼び出される関数
int start()
{
	int			startNo, countedNum, i, i2, myInt, myInt2, myInt3, buyFlag, sellFlag;
	bool		myBool1, myBool2, myBool3;
	double		myDouble, myDouble1, myDouble2, myDouble3, myDouble4, myDouble5, myStop, myLimit, myArray[];
	
	//--------------------------------------------------------------------
	// 初期化
	//--------------------------------------------------------------------
	
	//変化してないバーの数から、更新すべきカバーの数を計算
	startNo = Bars - gPreviousBar;
	if( Bars == startNo ) startNo = Bars - 1;
	
	//バーが増えたのなら
	if( gPreviousBar != Bars ){
	//配列をリサイズ

		ArrayCopy( myArray, gBuffer0Long );
		//ArrayResize( gBuffer0Long, Bars );
		ArrayCopy( gBuffer0Long, myArray, startNo, 0, 255 - startNo );
		ArrayCopy( myArray, gBuffer0Short );
		//ArrayResize( gBuffer0Short, Bars );
		ArrayCopy( gBuffer0Short, myArray, startNo, 0, 255 - startNo );

	}
	
	//--------------------------------------------------------------------
	// 決済
	//--------------------------------------------------------------------
	

	

	

	
	//--------------------------------------------------------------------
	// データを計算
	//--------------------------------------------------------------------
	
	//更新すべきバーの数だけループ
	for( i = startNo; 0 <= i; i-- ){

		//--------------------移動平均線--------------------
		gBuffer0Long[i] = iMA( NULL, 0, pMALongExp, 0, MODE_SMA, PRICE_CLOSE, i );
		gBuffer0Short[i] = iMA( NULL, 0, pMAShortExp, 0, MODE_SMA, PRICE_CLOSE, i );

	}
	
	//--------------------------------------------------------------------
	// 決済＆注文終了
	//--------------------------------------------------------------------
	

	

	

	

	
	//新しいバーの数を記録
	gPreviousBar = Bars;
	
	//--------------------------------------------------------------------
	// 注文条件チェック
	//--------------------------------------------------------------------
	
	//初期化
	buyFlag = 0;
	sellFlag = 0;
	

	//--------------------移動平均線--------------------

	//短期線が長期線を上抜いたら/上回っていたら買う
	if( gBuffer0Long[0] < gBuffer0Short[0] && gBuffer0Short[1] <= gBuffer0Long[1] ){
		if( buyFlag == 0 ) buyFlag = 1;
	} else {
		buyFlag = -1;
	}

	//短期線が長期線を下抜いたら/下回っていたら売る
	if( gBuffer0Short[0] < gBuffer0Long[0] && gBuffer0Long[1] <= gBuffer0Short[1] ){
		if( sellFlag == 0 ) sellFlag = 1;
	} else {
		sellFlag = -1;
	}


	
	//--------------------------------------------------------------------
	// 注文
	//--------------------------------------------------------------------
	
	//買い注文になって、以前注文したときからバー数が変わっているのなら
	if( buyFlag == 1 && gLastBuyBar != Bars ){
		//バー数を記録
		gLastBuyBar = Bars;
		

		//売り注文が残ってるのなら決済
		MyClose( OP_SELL, pLots, pSlipPage, pMagicNumber ); 

		
		//----------損切りと利食いを計算----------
		//初期化
		myStop = 0;
		myLimit = 0;
		myDouble1 = 0;
		myDouble2 = 0;
		myDouble3 = 0;
		myDouble4 = 0;
		
		//レート変動（％）で利食い／損切り

		
		//レート変動（Pips）で利食い、損切り

		
		//より低い利食い、より高い損切りに設定
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
		
		//買い注文を送信
		MyOrder( OP_BUY, pLots, pSlipPage, myStop, myLimit, pMagicNumber, 0 );
	}
	
	//売り注文になって、以前注文したときからバー数が変わっているのなら
	if( sellFlag == 1 && gLastSellBar != Bars ){
		//バー数を記録
		gLastSellBar = Bars;
		

		//買い注文が残ってるのなら決済
		MyClose( OP_BUY, pLots, pSlipPage, pMagicNumber ); 

		
		//----------損切りと利食いを計算----------
		//初期化
		myStop = 0;
		myLimit = 0;
		myDouble1 = 0;
		myDouble2 = 0;
		myDouble3 = 0;
		myDouble4 = 0;
		
		//レート変動（％）で利食い／損切り

		
		//レート変動（Pips）で利食い、損切り

		
		//より高い利食い、より低い損切りに設定
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
		
		//売り注文を送信
		MyOrder( OP_SELL, pLots, pSlipPage, myStop, myLimit, pMagicNumber, 0 );
	}
	
	return(0);
}

//--------------------------------------------------------------------

//注文処理
int MyOrder( int ordType, double lot, int slipPage, double stopLoss, double profit, int magicNumber, double expBarNum )
{
	int			i, ticket = -1;
	double		stopLossMin, stopLoss2, profit2;
	datetime	expDateTime = 0;
	
	//有効期限のバー数から日時を計算する
	if( 0 < expBarNum ) expDateTime = TimeCurrent() + (Period() * expBarNum * 60);
	
	//ストップロスが最小以下かどうかチェック
	//if( stopLoss != 0 ){
	//	stopLossMin = MarketInfo(Symbol(),MODE_STOPLEVEL);
	//	if( stopLoss < stopLossMin ) stopLoss = stopLossMin;
	//}
	
	//買いか売りかで分岐
	if ( ordType == OP_BUY ){
		//買い注文を送信
		ticket = OrderSend( Symbol(), OP_BUY, lot, Ask, slipPage, stopLoss, profit, NULL, magicNumber, expDateTime, Blue );
		if( ticket == -1 ){
			Print( "OrderSend error = ", GetLastError());
			return ( -1 );
		} else {
			//OrderSelect( ticket, SELECT_BY_TICKET );
			//OrderModify( ticket, OrderOpenPrice(), stopLoss, profit, 0, Blue );		
		}
	} else if ( ordType == OP_SELL ){
		//売り注文を送信
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

//決済処理
int MyClose( int ordType, double lots, int slipPage, int magicNumber )
{
	int		i, ticket = -1;
	bool	result;
	
	//注文の数だけループ
	for( i = OrdersTotal() - 1; 0 <= i; i-- ){
		//決済が終わってないのなら、選択
		if( OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == true ){
			//ペア種類とマジックナンバーが一致していたら
			if( OrderSymbol() == Symbol() && ( magicNumber == 0 || OrderMagicNumber() == magicNumber )) {
				//指定された注文なら
				if( ordType == -1 || OrderType() == ordType ){
					//このチケットNoを取得
					ticket = OrderTicket();
					
					//注文を決済
					if ( OrderType() == OP_BUY ) result = OrderClose( ticket, lots, Bid, slipPage );
					else if ( OrderType() == OP_SELL ) result = OrderClose( ticket, lots, Ask, slipPage );
					else result = OrderDelete( ticket );
					
					//結果がエラーなら表示
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
