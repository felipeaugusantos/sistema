unit untRcxRecbBaixDocs;

interface

uses
  UniClientDataSet, Uni, TypesRel, StrUtils, RLTypes, SysUtils, frxClass,
  Data.DB, System.Classes;

Type
  TRcxDadosCliente = Record
    strCodCli : String;
    strCodRed : String;
    strNomCli : String;
    strEndCli : String;
    strCepCli : String;
    strCidCli : String;
    fltValRec : Double;
  End;

  TRcxValoresReceb = Record
    strDinRec : String;
    strCarRec : String;
    strChqVis : String;
    strChqPre : String;
    strOrdRec : String;
    strCreRec : String;
  End;

  procedure pImpRecBaiDoc(cdsImpRec:TUniClientDataSet;
                          strRecRcx:String;
                          intSeqCon:Integer;
                          strCodOpe:String;
                          arrCodCli:Array Of TRcxDadosCliente;
                          recValRec:TRcxValoresReceb;
                          cdsChqPre:TUniClientDataSet=NIL;
                          cdsChqVis:TUniClientDataSet=NIL;
                          strNomFrm:String='';
                          strFilRel:String='';
                          strTipRel:String='';
                          blnEhLancamento:Boolean=False;
                          strEspLan:String='';
                          strCntPag:String='';
                          strNomeCli:String='';
                          blnResCai:Boolean=True;
                          strCodPor: String = '';
                          strHist02: String = '';
                          AModoVideo:Boolean = False);

  procedure pBuscaDescricaoFormaPagamento(strNumDoc, strEspDoc, strCodEmp: string; ASeqCon: Integer = 0;AEmpBai: String = '');
  function RetornaTotalTroco(ADataSet: TDataSet): Double;

Var
  blnCalculaTotais: Boolean;  //mudar isso na refatoração dos recibos

implementation
uses untCfgRel, untFuncoes, untFuncoesSimples,
  untQckRcxReciboCB, untQckReciboCtaReceber, untQckRcxRecBai40cB,
  untQckRcxReciboBai2Fast, untValorPorExtenso;

procedure pImpRecBaiDoc(cdsImpRec:TUniClientDataSet;
                        strRecRcx:String;
                        intSeqCon:Integer;
                        strCodOpe:String;
                        arrCodCli:Array Of TRcxDadosCliente;
                        recValRec:TRcxValoresReceb;
                        cdsChqPre:TUniClientDataSet=NIL;
                        cdsChqVis:TUniClientDataSet=NIL;
                        strNomFrm:String='';
                        strFilRel:String='';
                        strTipRel:String='';
                        blnEhLancamento:Boolean=False;
                        strEspLan:String='';
                        strCntPag:String='';
                        strNomeCli:String='';
                        blnResCai:Boolean=True;
                        strCodPor: String = '';
                        strHist02: String = '';
                        AModoVideo:Boolean = False);
 Var
   intContador:Integer;
   qryGenEmp,
   qryCfgRel: TUniQuery;
   LValorTotalTroco: Double;
   strForPag,
   strSQL,
   strNomFil,
   strTipImp: String;
   frxRelatorio: TfrxReport;
   blnUsaLayimp: Boolean;

   function fLoadReport: Boolean;
     Var
       mmsLoad: TStream;
       qryLayImp: TUniQuery;
  Begin
    Result := False;

    qryLayImp := fCriaQuery(nil);

    Try
      With qryLayImp, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT * FROM ');
        Add('  LAYIMP');
        Add('WHERE');
        Add('  LAY_TIPLAY = :TIPLAY AND  ');
        Add('  LAY_CODEMP = :CODEMP AND  ');
        Add('  LAY_CODLAY = :CODLAY      ');

        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODLAY').AsString := 'RELDOC';

        ParamByName('TIPLAY').AsString := 'L';

        Add('ORDER BY');
        Add('  LAY_DTAALT DESC,');
        Add('  LAY_HORALT DESC ');
        Add('LIMIT 1');
        Open;

        If Not IsEmpty Then
        Begin
          Try
            Result := True;
            mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);

            If Assigned(frxRelatorio) Then
            Begin
              frxRelatorio.LoadFromStream(mmsLoad);
              frxRelatorio.Variables.Clear;
            End;

          Finally
            pFreeAndNil(mmsLoad);
          End;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fLoadReport]');
      End;
    End;

    pFreeAndNil(qryLayImp);
  End;

   procedure pImprimeReciboBaiTranfe;
     Var
       intCont,
       intVias: Integer;
   begin
     Try
       pCriarFormularios(TfrmQckRcxReciboCB,frmQckRcxReciboCB);

       If strTipImp = 'M' Then
       Begin
         frxRelatorio := frmQckRcxReciboCB.frxQckRcxReciboCBM;
         frxRelatorio.Pages[0].Height := frxRelatorio.Pages[0].Height + (fCfgSis('QTDSAL', varInteger)*17);
         frxRelatorio.FindObject('rlbAssinatura').Height := frxRelatorio.FindObject('rlbAssinatura').Height + (fCfgSis('QTDSAL', varInteger)*17);
       End
       Else
         frxRelatorio := frmQckRcxReciboCB.frxQckRcxReciboCBJ;

       blnUsaLayimp := fLoadReport;

       frxRelatorio.Variables['SEQBAI'] := IntToStr(intSeqCon);

       If fCfgSis('SIGPAI', varString) = 'PAR' Then
       Begin
         frxRelatorio.Script.Variables['RELACAO']     := 'LISTA DE LOS DOCUMENTOS DESCARGADOS';
         frxRelatorio.Script.Variables['DESCRICAO']   := IIF(cdsImpRec.FieldByName('ESPDOC').AsString <> 'LC',
                                                         'PROVEEDOR - DESCRIPCION', 'DESCRIPCION');
         frxRelatorio.Script.Variables['VENC']        := 'MADUREZ';
         frxRelatorio.Script.Variables['CUSTO']       := 'PLAN GENERAL DE CONTABILIDAD';
         frxRelatorio.Script.Variables['CNPJ']        := 'RUC';
         frxRelatorio.Script.Variables['COMPENSACAO'] := 'ESTO SOLO ES VALIDO EN LA RECEPCION DE COMPENSACION CHEQUE';
         frxRelatorio.Script.Variables['RELPONSAVEL'] := 'RESPONSABLE';
       End
       Else
       Begin
         frxRelatorio.Script.Variables['RELACAO']     := 'RELACAO DE DOCUMENTOS BAIXADOS';
         frxRelatorio.Script.Variables['DESCRICAO']   := IIF(cdsImpRec.FieldByName('ESPDOC').AsString <> 'LC',
                                                         'FORNECEDOR - DESCRICAO', 'DESCRICAO');
         frxRelatorio.Script.Variables['VENC']        := 'DTA. VENC.';
         frxRelatorio.Script.Variables['CUSTO']       := 'PLANO DE CONTAS';
         frxRelatorio.Script.Variables['CNPJ']        := 'CNPJ/CPF';
         frxRelatorio.Script.Variables['COMPENSACAO'] := 'ESTE RECIBO SOMENTE SERA VALIDO NA COMPENSACAO DO CHEQUE';
         frxRelatorio.Script.Variables['RESPONSAVEL'] := 'RESPONSAVEL';
       End;

       frxRelatorio.FindObject('chiAvisoCheque').Visible := (Assigned(cdsChqPre) And cdsChqPre.Active And (Not cdsChqPre.IsEmpty)) Or
                                                            (Assigned(cdsChqVis) And cdsChqVis.Active And (Not cdsChqVis.IsEmpty));

       frxRelatorio.FindObject('chiChePre').Visible := (Assigned(cdsChqPre) And cdsChqPre.Active And (Not cdsChqPre.IsEmpty));
       frxRelatorio.FindObject('chiCheAvi').Visible := (Assigned(cdsChqVis) And cdsChqVis.Active And (Not cdsChqVis.IsEmpty));

       If Assigned(cdsChqPre) Then
       Begin
         If cdsChqPre.Active Then
           cdsChqPre.First
         Else
           cdsChqPre.Open;
       End;

       If Assigned(cdsChqVis) Then
       Begin
         If cdsChqVis.Active Then
           cdsChqVis.First
         Else
           cdsChqVis.Open;
       End;

       frmQckRcxReciboCB.frxChePre.DataSet := cdsChqPre;
       frmQckRcxReciboCB.frxCheAvi.DataSet := cdsChqVis;

       If Not blnUsaLayimp Then  // Req 208069
       Begin
         If strEspLan = 'PG' Then
         Begin
           frxRelatorio.FindObject('rlbDesCta').Visible := True;
           frxRelatorio.FindObject('rlbNomCta').Visible := True;
           TfrxMemoView(frxRelatorio.FindObject('rlbNomCta')).Text := strCntPag + '-' + fRetNomeConta(strCntPag);
         End
         Else
         Begin
           If strTipImp = 'M' Then
           Begin
             TfrxMemoView(frxRelatorio.FindObject('rlbTitDescri')).Top := 30;
             TfrxMemoView(frxRelatorio.FindObject('rlbDescricao')).Top := 30;
             frxRelatorio.FindObject('rlbCab').Height     := 50;
             frxRelatorio.FindObject('rlbDetalhe').Height := 50;
           End
           Else
           Begin
             TfrxMemoView(frxRelatorio.FindObject('rlbTitDescri')).Top := 40;
             TfrxMemoView(frxRelatorio.FindObject('rlbDescricao')).Top := 40;
             frxRelatorio.FindObject('rlbCab').Height     := 60;
             frxRelatorio.FindObject('rlbDetalhe').Height := 60;

             If cdsImpRec.FieldByName('ESPDOC').AsString = 'LC' Then
             Begin
               TfrxMemoView(frxRelatorio.FindObject('rllNomEmp')).HAlign := TfrxHAlign.haLeft;
               TfrxMemoView(frxRelatorio.FindObject('rllFone001')).HAlign := TfrxHAlign.haLeft;
               TfrxMemoView(frxRelatorio.FindObject('rllCidEmp')).HAlign := TfrxHAlign.haLeft;
               TfrxMemoView(frxRelatorio.FindObject('rllTitulo')).HAlign := TfrxHAlign.haLeft;
             End;
           End;
         End;
       End
       Else
       Begin
         strForPag := '';
         strForPag := strForPag + 'DINHEIRO: ' + fPadL(recValRec.strDinRec,9) + ' ';
         strForPag := strForPag + 'CARTAO  : ' + fPadL(recValRec.strCarRec,9) + #13#10;
         strForPag := strForPag + 'CHQ. VIS: ' + fPadL(recValRec.strChqVis,9) + ' ';
         strForPag := strForPag + 'CHQ. PRE: ' + fPadL(recValRec.strChqPre,9) + #13#10;
         strForPag := strForPag + 'ORD. PAG: ' + fPadL(recValRec.strOrdRec,9);
       End;

       If VerImpressoraONLINE(strNomFil) <> 0 Then
       Begin
         fMensagem('ATENÇÃO!', 'Impressora "' + strNomFil + '" está OFFLINE! Selecione outra!', ['&OK']);
         frxRelatorio.PrintOptions.ShowDialog := True;
       End
       Else
         frxRelatorio.PrintOptions.ShowDialog := False;

       frxRelatorio.PrintOptions.Printer    := AnsiReplaceStr(strNomFil,'\\' + fRetNomeRede + '\','');
       frxRelatorio.PreviewOptions.Buttons  := [pbPrint,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];

       frmQckRcxReciboCB.strForPag := strForPag;
       frmQckRcxReciboCB.frxDotMatrixExport.PageBreaks := False;
       frmQckRcxReciboCB.frxRelatorio.DataSet := cdsImpRec;

       If frxRelatorio.PrepareReport Then
       Begin
         If cdsImpRec.FieldByName('ESPDOC').AsString = 'LC' Then
           intVias := fCfgSis('VIASLC', varInteger)
         Else If cdsImpRec.FieldByName('ESPDOC').AsString = 'PG' Then
           intVias := fCfgSis('VIASPG', varInteger)
         Else If cdsImpRec.FieldByName('ESPDOC').AsString = 'LD' Then
           intVias := fCfgSis('VIASLD', varInteger)
         Else
           intVias := fCfgSis('VIAREC', varInteger);

         If (AModoVideo) Then
            pPreviewReport(strNomFrm, 'Baixa de duplicatas - Recibo', frxRelatorio)
         Else
           For intCont := 1 to intVias Do
             pPrintReport(strNomFrm, 'Baixa de duplicatas - Recibo', strNomFil, frxRelatorio);

       End;

     Except
       On E: Exception Do
       Begin
         pMensagensErro(E.Message, '[pImprimeReciboBaiTranfe]');
       End;
     End;

     pFreeAndNil(frmQckRcxReciboCB);
     pFreeAndNil(frxRelatorio);

   end;

   procedure pImprimeReciboBaiColuna;
     Var
       intCont,
       intVias: Integer;
       strValExt   : String;
       cdsAux      : TUniClientDataSet;
   Begin
     Try

       {**************************}
       { Impressão a Laser        }
       {***********************MA*}

       If fEmptyStr(strFilRel) Then
       Begin
         pCarregaConfImpr(qryCfgRel, 'frmRcxSelDocumentos');
         fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);
         strNomFrm := 'frmRcxSelDocumentos';
       End
       Else
       Begin
         strNomFil:=strFilRel;
         strTipImp:=strTipRel;
       End;

       pCriarFormularios(TfrmQckReciboBai2Fast,frmQckReciboBai2Fast);
       If (fCfgSis('LAYREC') = '1') Then
       Begin
         {*********************************************************}
         { Meia Folha, não imprime cheques (2 recibos por folha).  }
         {******************************************************MA*}
         frmQckReciboBai2Fast.frxRel := frmQckReciboBai2Fast.frxRelReciboSemChqJ;
       End
       Else
       Begin
         {******************************************************}
         { Folha Inteira, imprime cheques (1 recibo por folha)  }
         {***************************************************MA*}

         If (strTipImp = 'M') Then
         Begin
           frmQckReciboBai2Fast.frxRel := frmQckReciboBai2Fast.frxReciboColunaCtaReceber;
           frmQckReciboBai2Fast.frxRel.reportOptions.Compressed := True;

         End
         Else
           frmQckReciboBai2Fast.frxRel := frmQckReciboBai2Fast.frxRelReciboJ;

       End;

       If Not (strTipImp = 'M') Then
       Begin
         frmQckReciboBai2Fast.frxRel.DotMatrixReport           := False;
         frmQckReciboBai2Fast.frxRel.PrintOptions.PrintMode    := pmScale;
         frmQckReciboBai2Fast.frxRel.PrintOptions.PrintOnSheet := 9; //A4
       End;

       If cdsImpRec.FieldByName('ESPDOC').AsString = 'LC' Then
         intVias := fCfgSis('VIASLC', varInteger)
       Else If cdsImpRec.FieldByName('ESPDOC').AsString = 'PG' Then
         intVias := fCfgSis('VIASPG', varInteger)
       Else If cdsImpRec.FieldByName('ESPDOC').AsString = 'LD' Then
         intVias := fCfgSis('VIASLD', varInteger)
       Else
         intVias := fCfgSis('VIAREC', varInteger);

       If (intVias > 1) And Not (strTipImp = 'M') Then
       Begin
         For intCont := 1 To intVias Do
           frmQckReciboBai2Fast.frxRel.Pages[intCont].Visible := True;
       End;

       If cdsImpRec.RecordCount <= 22 Then
         frmQckReciboBai2Fast.frxRelatorio.DataSet := cdsImpRec
       Else
       Begin
         cdsAux := TUniClientDataSet.Create(NIL);
         cdsImpRec.IndexFieldNames := 'NUMDOC';
         cdsAux := fCriaClientDatset(cdsImpRec);
         cdsAux.Open;

         frmQckReciboBai2Fast.frxRelatorio.DataSet := cdsAux;

         frmQckReciboBai2Fast.frxRel.FindObject('rllContinua').Visible     := True;
         If  Not (strTipImp = 'M') Then
         Begin
           For intCont := 2 To intVias Do
           Begin
             frmQckReciboBai2Fast.frxRel.FindObject('rllContinua' + IntToStr(intCont) + 'Via').Visible := True;
           End;
         End;
       End;

       frmQckReciboBai2Fast.cdsCadChq.CreateDataSet;
       frmQckReciboBai2Fast.cdsCadChq.Open;

       pAdicionaCheques(cdsChqPre, frmQckReciboBai2Fast.cdsCadChq);
       pAdicionaCheques(cdsChqVis, frmQckReciboBai2Fast.cdsCadChq);

       frmQckReciboBai2Fast.frxCheques.DataSet := frmQckReciboBai2Fast.cdsCadChq;

       {********************************************}
       { Se as vias do recibo saem cada uma em meia }
       { folha não imprime informações do cheque.   }
       {*****************************************MA*}

       If (fCfgSis('LAYREC') <> '1') And Not (strTipImp = 'M') Then
       Begin
         {**********************************************}
         { Se as vias do recibo saem em sequência na    }
         { mesma página imprime informações do cheque.  }
         {*******************************************MA*}

         If Not frmQckReciboBai2Fast.cdsCadChq.IsEmpty Then
         Begin
           {*********************************}
           { Pagamento realizado com chegue  }
           {******************************MA*}
           If intVias > 1 Then
           Begin
             For intCont := 1 To intVias Do
               frmQckReciboBai2Fast.frxRel.Pages[intCont + 5].Visible := True;
           End;
         End;
       End;

       arrCodCli[intContador].strCepCli := AnsiReplaceStr(arrCodCli[intContador].strCepCli, '-', '');
       arrCodCli[intContador].strCepCli := Copy(arrCodCli[intContador].strCepCli, 1, 5) + '-' +
                                           Copy(arrCodCli[intContador].strCepCli, 6, 3);

       strValExt := fRetExtensoNumero(FloatToStr(arrCodCli[intContador].fltValRec + LValorTotalTroco));

       frmQckReciboBai2Fast.frxRel.Script.Variables['NOMCLI'] := arrCodCli[intContador].strNomCli;
       frmQckReciboBai2Fast.frxRel.Script.Variables['ENDCLI'] := arrCodCli[intContador].strEndCli + ' - ';
       frmQckReciboBai2Fast.frxRel.Script.Variables['CEPCLI'] := arrCodCli[intContador].strCepCli + ' - ';
       frmQckReciboBai2Fast.frxRel.Script.Variables['CIDCLI'] := arrCodCli[intContador].strCidCli;
       frmQckReciboBai2Fast.frxRel.Script.Variables['ESTCLI'] :=  '';
       frmQckReciboBai2Fast.frxRel.Script.Variables['VALREC'] := arrCodCli[intContador].fltValRec + LValorTotalTroco;
       frmQckReciboBai2Fast.frxRel.Script.Variables['VALEXT'] := strValExt;
       frmQckReciboBai2Fast.frxRel.Script.Variables['NOMEMP'] := qryGenEmp.FieldByName('EMP_NOMEMP').AsString;
       frmQckReciboBai2Fast.frxRel.Script.Variables['ENDERE'] := qryGenEmp.FieldByName('EMP_ENDERE').AsString+', '+
                                                                 qryGenEmp.fieldbyname('EMP_ENDNUM').AsString;
       frmQckReciboBai2Fast.frxRel.Script.Variables['C_E_P_'] := qryGenEmp.FieldByName('EMP_C_E_P_').AsString;
       frmQckReciboBai2Fast.frxRel.Script.Variables['CIDADE'] := fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString);
       frmQckReciboBai2Fast.frxRel.Script.Variables['ESTADO'] := fRetNomCidade(qryGenEmp.FieldByName('EMP_CODCID').AsString, 1);
       frmQckReciboBai2Fast.frxRel.Script.Variables['CNPJ']   := 'CNPJ: ' + qryGenEmp.FieldByName('EMP_C_G_C_').AsString;
       frmQckReciboBai2Fast.frxRel.Script.Variables['INSEST'] := 'INSCRICAO ESTADUAL: ' + qryGenEmp.FieldByName('EMP_I_E_S_').AsString;
       frmQckReciboBai2Fast.frxRel.Script.Variables['SEQCON'] := 'SEQ. BAIXA: ' + IntToStr(intSeqCon);
       frmQckReciboBai2Fast.frxRel.Script.Variables['DTAREC'] := FormatDateTime('dd/mm/yyyy', VS_Date);
       frmQckReciboBai2Fast.frxRel.Script.Variables['CODOPE'] := fRetNomeOperador(strCodOpe);
       frmQckReciboBai2Fast.frxRel.Script.Variables['CODEMP'] := qryGenEmp.FieldByName('EMP_CODEMP').AsString;
       frmQckReciboBai2Fast.frxRel.Script.Variables['CAIXA'] := cdsImpRec.FieldByName('RCX_CAIXA').AsString;

       pBuscaDescricaoFormaPagamento(cdsImpRec.FieldByName('NUMDOC').AsString,
                                     cdsImpRec.FieldByName('ESPDOC').AsString,
                                     cdsImpRec.FieldByName('CODEMP').AsString,
                                     intSeqCon,VS_strCodEmp);

       If (fCfgSis('LAYREC') <> '1') And Not  (strTipImp = 'M')  then
       Begin
         if (fCfgSis('INFREC',varBoolean)) then
         begin
           TfrxFooter(frmQckReciboBai2Fast.frxRel.FindObject('rlbCheques')).Child := TfrxChild(frmQckReciboBai2Fast.frxRel.FindObject('rlbEmpresa'));
         end
         else
         begin
           TfrxFooter(frmQckReciboBai2Fast.frxRel.FindObject('rlbCheques')).Child := TfrxChild(frmQckReciboBai2Fast.frxRel.FindObject('rlbEmpresa2'));
         end;
       End;

       If VerImpressoraONLINE(strNomFil) <> 0 Then
       Begin
         fMensagem('ATENÇÃO!', 'Impressora "' + strNomFil + '" está OFFLINE! Selecione outra!', ['&OK']);
         frmQckReciboBai2Fast.frxRel.PrintOptions.ShowDialog := True;
       End
       Else
         frmQckReciboBai2Fast.frxRel.PrintOptions.ShowDialog := False;

       frmQckReciboBai2Fast.frxRel.PrintOptions.Printer    := AnsiReplaceStr(strNomFil,'\\' + fRetNomeRede + '\','');
       frmQckReciboBai2Fast.frxRel.PreviewOptions.Buttons  := [pbPrint,pbLoad,pbSave,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];

       If (frmQckReciboBai2Fast.frxRel.PrepareReport) Then
         pPrintReport(strNomFrm, 'Baixa de duplicatas - Recibo', strNomFil, frmQckReciboBai2Fast.frxRel);

       If cdsImpRec.RecordCount > 22 Then
       Begin
         For intCont := 0 To 21 Do
         Begin
           cdsImpRec.First;
           cdsImpRec.Delete;
         End;

         frmQckReciboBai2Fast.cdsCadChq.Close;
         pFreeAndNil(frmQckReciboBai2Fast);
         FreeAndNil(cdsAux);

         pImprimeReciboBaiColuna;
       End
       Else
       Begin
         frmQckReciboBai2Fast.cdsCadChq.Close;
         pFreeAndNil(frmQckReciboBai2Fast);
       End;

     Except
       On E: Exception Do
       Begin
         pMensagensErro(E.Message, '[pImprimeReciboBaiColuna]');
       End;
     End;

   End;

   procedure pImprimeReciboBaiLinhas;
     Var
       intVias: Integer;
   begin
     Try
       pCriarFormularios(TfrmQckReciboCtaReceber, frmQckReciboCtaReceber);

       If cdsImpRec.FieldByName('ESPDOC').AsString = 'LC' Then
         intVias := fCfgSis('VIASLC', varInteger)
       Else If cdsImpRec.FieldByName('ESPDOC').AsString = 'PG' Then
         intVias := fCfgSis('VIASPG', varInteger)
       Else If cdsImpRec.FieldByName('ESPDOC').AsString = 'LD' Then
         intVias := fCfgSis('VIASLD', varInteger)
       Else
         intVias := fCfgSis('VIAREC', varInteger);

       frmQckReciboCtaReceber.blnCalculaTotais := blnCalculaTotais;

       frmQckReciboCtaReceber.pImprimeRecibo(False,
                                             TCfgRel.VS_blnDlgPri,
                                             strNomFrm,
                                             strTipImp,
                                             strNomFil,
                                             IntToStr(intSeqCon),
                                             cdsImpRec,
                                             intVias,
                                             blnResCai,
                                             fStrToFloat(recValRec.strChqPre),
                                             fStrToFloat(recValRec.strChqVis),
                                             fStrToFloat(recValRec.strCarRec),
                                             fStrToFloat(recValRec.strDinRec),
                                             fStrToFloat(recValRec.strOrdRec),
                                             fStrToFloat(recValRec.strCreRec),
                                             fRetNomeOperador(strCodOpe),
                                             strEspLan,
                                             cdsChqPre,
                                             cdsChqVis,
                                             strNomeCli,
                                             strCodPor,
                                             strHist02);
     Except
       On E: Exception Do
       Begin
         pMensagensErro(E.Message, '[pImprimeReciboBaiLinhas]');
       End;
     End;

     pFreeAndNil(frmQckReciboCtaReceber);

   end;

   procedure pImprimeReciboBaiBobina;
     Var
       intCont : Integer;
   Begin

     Try
       pCriarFormularios(TfrmQckRcxRecBai40cB, frmQckRcxRecBai40cB);
       frmQckRcxRecBai40cB.dspRecibo.DataSet := cdsImpRec;
       frmQckRcxRecBai40cB.cdsRecibo.ProviderName := frmQckRcxRecBai40cB.dspRecibo.Name;
       frmQckRcxRecBai40cB.cdsRecibo.Open;

       frmQckRcxRecBai40cB.frxRecibo.Script.Variables['EMPRESA']  := qryGenEmp.fieldbyname('EMP_NOMFAN').AsString;
       frmQckRcxRecBai40cB.frxRecibo.Script.Variables['TELEFONE'] := qryGenEmp.fieldbyname('EMP_FONE01').AsString;
       frmQckRcxRecBai40cB.frxRecibo.Script.Variables['ENDERECO'] := qryGenEmp.fieldbyname('EMP_ENDERE').AsString +
                                                                    ','  + qryGenEmp.fieldbyname('EMP_ENDNUM').AsString +
                                                                    '  ' + qryGenEmp.fieldbyname('EMP_ENDCMP').AsString +
                                                                    '-' + qryGenEmp.fieldbyname('EMP_BAIRRO').AsString;
       frmQckRcxRecBai40cB.frxRecibo.Script.Variables['CIDADE']   := qryGenEmp.fieldbyname('CIDADE').AsString;
       frmQckRcxRecBai40cB.frxRecibo.Script.Variables['DATA']     := qryGenEmp.fieldbyname('CIDADE').AsString + ', ' + FormatDateTime('dd/MM/yyyy',VS_Date);

       If fCfgSis('SIGPAI', varString) = 'PAR' Then
       Begin
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['RELACAO']     := 'LISTA DE LOS DOCUMENTOS DESCARGADOS';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['EMP']         := 'NEG';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['DESCRICAO']   := 'DESCRIPCION';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['VENC']        := 'MADUREZ';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['CNPJ']        := 'RUC';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['COMPENSACAO'] := 'ESTO SOLO ES VALIDO EN LA RECEPCION DE COMPENSACION CHEQUE';
       End
       Else
       Begin
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['RELACAO']     := 'RELACAO DE DOCUMENTOS BAIXADOS';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['EMP']         := 'EMP';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['DESCRICAO']   := 'DESCRICAO';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['VENC']        := 'DTA. VENC.';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['CNPJ']        := 'CNPJ/CPF';
         frmQckRcxRecBai40cB.frxRecibo.Script.Variables['COMPENSACAO'] := 'ESTE RECIBO SOMENTE SERA VALIDO NA COMPENSACAO DO CHEQUE';
       End;

       frmQckRcxRecBai40cB.frxRecibo.Script.Variables['CAIXA'] := cdsImpRec.FieldByName('RCX_CAIXA').AsString;

       frmQckRcxRecBai40cB.strCodOpe := strCodOpe;

       frmQckRcxRecBai40cB.frxRecibo.FindObject('chiAvisoCheque').Visible := (Assigned(cdsChqPre) And cdsChqPre.Active And (Not cdsChqPre.IsEmpty)) Or
                                                            (Assigned(cdsChqVis) And cdsChqVis.Active And (Not cdsChqVis.IsEmpty));

       frmQckRcxRecBai40cB.frxRecibo.FindObject('chiChePre').Visible := (Assigned(cdsChqPre) And cdsChqPre.Active And (Not cdsChqPre.IsEmpty));
       frmQckRcxRecBai40cB.frxRecibo.FindObject('chiCheAvi').Visible := (Assigned(cdsChqVis) And cdsChqVis.Active And (Not cdsChqVis.IsEmpty));

       If Assigned(frmQckRcxRecBai40cB.frxRecibo.FindObject('memRefere')) And fLoadReport Then
         frmQckRcxRecBai40cB.frxRecibo.FindObject('memRefere').Visible := True;

       If Assigned(cdsChqPre) Then
       Begin
         If cdsChqPre.Active Then
           cdsChqPre.First
         Else
           cdsChqPre.Open;
       End;

       If Assigned(cdsChqVis) Then
       Begin
         If cdsChqVis.Active Then
           cdsChqVis.First
         Else
           cdsChqVis.Open;
       End;

       frmQckRcxRecBai40cB.frxChePre.DataSet := cdsChqPre;
       frmQckRcxRecBai40cB.frxCheAvi.DataSet := cdsChqVis;

       For intCont := 1 To fCfgSis('QTDSAL', varInteger) Do
         TfrxMemoView(frmQckRcxRecBai40cB.frxRecibo.FindObject('rllSalto')).Lines.Add('');

       If VerImpressoraONLINE(strNomFil) <> 0 Then
       Begin
         fMensagem('ATENÇÃO!', 'Impressora "' + strNomFil + '" está OFFLINE! Selecione outra!', ['&OK']);
         frmQckRcxRecBai40cB.frxRecibo.PrintOptions.ShowDialog := True;
       End
       Else
         frmQckRcxRecBai40cB.frxRecibo.PrintOptions.ShowDialog := False;

       frmQckRcxRecBai40cB.frxRecibo.PrintOptions.Printer := AnsiReplaceText(strNomFil,'\\' + fRetNomeRede + '\','');

       If frmQckRcxRecBai40cB.frxRecibo.PrepareReport Then
       Begin
         If cdsImpRec.FieldByName('ESPDOC').AsString = 'LC' Then
           frmQckRcxRecBai40cB.frxRecibo.PrintOptions.Copies := fCfgSis('VIASLC', varInteger)
         Else
           frmQckRcxRecBai40cB.frxRecibo.PrintOptions.Copies := fCfgSis('VIAREC', varInteger);

         If AModoVideo Then
           pPreviewReport(strNomFrm, 'Baixa de duplicatas - Recibo', frmQckRcxRecBai40cB.frxRecibo)
         Else
           pPrintReport(strNomFrm, 'Baixa de duplicatas - Recibo', strNomFil, frmQckRcxRecBai40cB.frxRecibo);
       End;

     Except
       On E: Exception Do
       Begin
         pMensagensErro(E.Message, '[pImprimeReciboBaiBobina]');
       End;
     End;

     pFreeAndNil(frmQckRcxRecBai40cB);
   End;

begin
  LValorTotalTroco := RetornaTotalTroco(cdsImpRec);

  With cdsImpRec Do
  Begin
    IndexFieldNames := 'DESCRI';
    First;

    If Not cdsImpRec.IsEmpty Then
    Begin
      qryCfgRel:=fCriaQuery;
      qryGenEmp:=fCriaQuery;
      Try
        If fEmptyStr(strFilRel) And Not AModoVideo Then
        Begin
          pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixa');
          fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);
          strNomFrm := 'frmRcxResumoCaixa';
        End
        Else
        Begin
          strNomFil:=strFilRel;
          strTipImp:=strTipRel;
        End;

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  CADEMP.*, ';
        strSQL := strSQL + '  CONCAT(CID_NOMCID, "-",CID_ESTADO) AS CIDADE ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADEMP, ';
        strSQL := strSQL + '  CADCID ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  EMP_CODCID = CID_CODCID AND ';
        strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

        With qryGenEmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          Open;
        End;

        Case strRecRcx[1] Of
          'C':Begin //COLUNA
                For intContador := 0 To Length(arrCodCli) -1 Do
                Begin
                  cdsImpRec.Filtered := False;
                  cdsImpRec.Filter   := 'CODCLI = ' + QuotedStr(arrCodCli[intContador].strCodCli);
                  cdsImpRec.Filtered := True;
                  First;
                  pImprimeReciboBaiColuna;
                End;
              End;
          'L':Begin //LINHA
                If blnEhLancamento then
                Begin
                  With recValRec Do
                  Begin
                    strForPag := '';
                    strForPag := strForPag + 'DINHEIRO: ' + fPadL(strDinRec,9) + ' ';
                    strForPag := strForPag + '  CARTAO: ' + fPadL(strCarRec,9) + #13#10;
                    strForPag := strForPag + 'CHQ. VIS: ' + fPadL(strChqVis,9) + ' ';
                    strForPag := strForPag + 'CHQ. PRE: ' + fPadL(strChqPre,9) + #13#10;
                    strForPag := strForPag + 'ORD. PAG: ' + fPadL(strOrdRec,9);
                  End;
                  pImprimeReciboBaiTranfe;
                End
                Else
                Begin
                  pImprimeReciboBaiLinhas;
                End
              End;
          'B':Begin //BOBINA
                For intContador := 0 To Length(arrCodCli) -1 Do
                Begin
                  cdsImpRec.Filtered := False;
                  cdsImpRec.Filter   := 'CODCLI = ' + QuotedStr(arrCodCli[intContador].strCodCli);
                  cdsImpRec.Filtered := True;
                  First;
                  pImprimeReciboBaiBobina;
                End;
              End;
        End;
      Finally
        FreeAndNil(qryCfgRel);
        FreeAndNil(qryGenEmp);
      End;
    End;
  End;
end;

procedure pBuscaDescricaoFormaPagamento(strNumDoc, strEspDoc, strCodEmp: string;ASeqCon: Integer = 0; AEmpBai: String = '');
var
  qryFormaPagto: TUniQuery;
begin
  qryFormaPagto := fCriaQuery();

  try
    qryFormaPagto.Close;
    qryFormaPagto.SQL.Clear;
    qryFormaPagto.SQL.Add('SELECT ADT_VALCAR, ADT_VALCHP, ADT_VALCHV, ADT_VALCRE, ADT_VALDIN, ADT_VALORD');
    qryFormaPagto.SQL.Add('FROM ADTCLI');
    qryFormaPagto.SQL.Add('WHERE ADT_CODEMP = :CODEMP');
    qryFormaPagto.SQL.Add('AND ADT_ESPDOC = :ESPDOC');
    qryFormaPagto.SQL.Add('AND ADT_NUMDOC = :NUMDOC');

    qryFormaPagto.ParamByName('CODEMP').AsString := strCodEmp;
    qryFormaPagto.ParamByName('ESPDOC').AsString := strEspDoc;
    qryFormaPagto.ParamByName('NUMDOC').AsString := strNumDoc;

    qryFormaPagto.Open;

    if not qryFormaPagto.IsEmpty then
    begin
      frmQckReciboBai2Fast.frxRel.Script.Variables['DINHEIRO'] := FloatToStr(qryFormaPagto.FieldByName('ADT_VALDIN').AsFloat);
      frmQckReciboBai2Fast.frxRel.Script.Variables['CARTAO']   := FloatToStr(qryFormaPagto.FieldByName('ADT_VALCAR').AsFloat);
      frmQckReciboBai2Fast.frxRel.Script.Variables['CHEVIS']   := FloatToStr(qryFormaPagto.FieldByName('ADT_VALCHV').AsFloat);
      frmQckReciboBai2Fast.frxRel.Script.Variables['ORDEM']    := FloatToStr(qryFormaPagto.FieldByName('ADT_VALORD').AsFloat);
      frmQckReciboBai2Fast.frxRel.Script.Variables['CHEPRE']   := FloatToStr(qryFormaPagto.FieldByName('ADT_VALCHP').AsFloat);
      frmQckReciboBai2Fast.frxRel.Script.Variables['CREDITO']  := FloatToStr(qryFormaPagto.FieldByName('ADT_VALCRE').AsFloat);
    end
    Else If Not fEmptyStr(AEmpBai) Then
    Begin
      qryFormaPagto.Close;
      qryFormaPagto.SQL.Clear;
      qryFormaPagto.SQL.Add('SELECT ');
      qryFormaPagto.SQL.Add('  SUM(RCX_CARREC) AS RCX_CARREC, ');
      qryFormaPagto.SQL.Add('  SUM(RCX_CHQPRE) AS RCX_CHQPRE, ');
      qryFormaPagto.SQL.Add('  SUM(RCX_VALCRE) AS RCX_VALCRE, ');
      qryFormaPagto.SQL.Add('  SUM(RCX_CHQAVI) AS RCX_CHQAVI, ');
      qryFormaPagto.SQL.Add('  SUM(RCX_DINREC) AS RCX_DINREC, ');
      qryFormaPagto.SQL.Add('  SUM(RCX_ORDREC) AS RCX_ORDREC  ');
      qryFormaPagto.SQL.Add('FROM CADRCXX');
      qryFormaPagto.SQL.Add('WHERE RCX_CODEMP = :CODEMP');
      qryFormaPagto.SQL.Add('AND RCX_SEQCON = :SEQCON');

      qryFormaPagto.ParamByName('CODEMP').AsString := AEmpBai;
      qryFormaPagto.ParamByName('SEQCON').AsInteger := ASeqCon;


      qryFormaPagto.Open;

      if not qryFormaPagto.IsEmpty then
      begin
        frmQckReciboBai2Fast.frxRel.Script.Variables['DINHEIRO'] := FloatToStr(qryFormaPagto.FieldByName('RCX_DINREC').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CARTAO']   := FloatToStr(qryFormaPagto.FieldByName('RCX_CARREC').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CHEVIS']   := FloatToStr(qryFormaPagto.FieldByName('RCX_CHQAVI').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['ORDEM']    := FloatToStr(qryFormaPagto.FieldByName('RCX_ORDREC').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CHEPRE']   := FloatToStr(qryFormaPagto.FieldByName('RCX_CHQPRE').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CREDITO']  := FloatToStr(qryFormaPagto.FieldByName('RCX_VALCRE').AsFloat);
      end
      else
      begin
        frmQckReciboBai2Fast.frxRel.Script.Variables['DINHEIRO'] := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CARTAO']   := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CHEVIS']   := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['ORDEM']    := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CHEPRE']   := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CREDITO']  := FloatToStr(0);
      end;
    End
    else
    begin
      qryFormaPagto.Close;
      qryFormaPagto.SQL.Clear;
      qryFormaPagto.SQL.Add('SELECT RCX_CARREC, RCX_CHQPRE, RCX_CHQAVI, RCX_VALCRE, RCX_DINREC, RCX_ORDREC');
      qryFormaPagto.SQL.Add('FROM CADRCXX');
      qryFormaPagto.SQL.Add('WHERE RCX_CODEMP = :CODEMP');
      qryFormaPagto.SQL.Add('AND RCX_ESPDOC = :ESPDOC');
      qryFormaPagto.SQL.Add('AND RCX_NUMDOC = :NUMDOC');
      qryFormaPagto.SQL.Add('AND RCX_EMPDUP = :EMPDUP');
      qryFormaPagto.SQL.Add('AND RCX_SEQBAI = 0');

      qryFormaPagto.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryFormaPagto.ParamByName('ESPDOC').AsString := strEspDoc;
      qryFormaPagto.ParamByName('NUMDOC').AsString := strNumDoc;
      qryFormaPagto.ParamByName('EMPDUP').AsString := strCodEmp;

      qryFormaPagto.Open;

      if not qryFormaPagto.IsEmpty then
      begin
        frmQckReciboBai2Fast.frxRel.Script.Variables['DINHEIRO'] := FloatToStr(qryFormaPagto.FieldByName('RCX_DINREC').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CARTAO']   := FloatToStr(qryFormaPagto.FieldByName('RCX_CARREC').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CHEVIS']   := FloatToStr(qryFormaPagto.FieldByName('RCX_CHQAVI').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['ORDEM']    := FloatToStr(qryFormaPagto.FieldByName('RCX_ORDREC').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CHEPRE']   := FloatToStr(qryFormaPagto.FieldByName('RCX_CHQPRE').AsFloat);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CREDITO']  := FloatToStr(qryFormaPagto.FieldByName('RCX_VALCRE').AsFloat);
      end
      else
      begin
        frmQckReciboBai2Fast.frxRel.Script.Variables['DINHEIRO'] := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CARTAO']   := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CHEVIS']   := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['ORDEM']    := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CHEPRE']   := FloatToStr(0);
        frmQckReciboBai2Fast.frxRel.Script.Variables['CREDITO']  := FloatToStr(0);
      end;
    end;
  finally
    FreeAndNil(qryFormaPagto);
  end;
end;

function RetornaTotalTroco(ADataSet: TDataSet): Double;
var
  LValorTotal: Double;
begin
  Result := 0;

  if not Assigned(ADataSet) then
    Exit;

  if not ADataSet.Active then
    Exit;

  if ADataSet.FindField('VALOR_TROCO') = nil then
    Exit;

  LValorTotal := 0;

  ADataSet.DisableControls;
  try
    ADataSet.First;
    while not ADataSet.Eof do
    begin
      LValorTotal := LValorTotal + ADataSet.FieldByName('VALOR_TROCO').AsFloat;
      ADataSet.Next;
    end;
  finally
    ADataSet.EnableControls;
  end;

  Result := LValorTotal;
end;

end.
