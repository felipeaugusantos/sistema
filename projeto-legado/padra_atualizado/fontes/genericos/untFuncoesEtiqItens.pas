unit untFuncoesEtiqItens;

interface

Uses
  Windows,
  Forms,
  Controls,
  SysUtils,
  strUtils,
  untTypesSistema, TypesRel,
  untFuncoesRel2,
  untFuncoesRel,
  Uni;

  Function fEscolheTabelaPreco(blnComPro: Boolean;
                               Var blnPromoc,
                                   blnImpPre: Boolean;
                               Var intPreco: Integer;
                                   blnComPre: Boolean;
                               Var blnPrePro: Boolean;
                               strTitulo: String = ''): Boolean;

  Function fEscolheTipoEtiqueta(Var tpeTipEti: TTipoEtiqueta;
                                    blnComPro: Boolean;
                                Var blnPromoc: Boolean;
                                Var intTabPre: Integer;
                                Var strCndPag: String;
                                Var strConPag: String;
                                var strNumPar: String;
                                Var strDesSel: String;
                                Var blnPrePro: Boolean;
                                    blnApenasTipoEtiqueta: Boolean = False;
                                    blnDefinirTipoNenhum : Boolean = False): Boolean;

  Function fRetornaLAY_DESCRI(tpeTipEtq: TTipoEtiqueta): String;

  Function fRetornaCndPag(var strCodCnd: String;
                          var strCndPag: String;
                          var strNumPar: String): Boolean;

  function fRetornaSQLMarcaIte(intQtdEti: Integer; blnUtilizarReplace: Boolean = False): String;
  Function fRetornaSQLDesmarcaIte: String;

implementation

uses untFuncoesSimples, untConfirmaPreco, untCondPagEti;

Function fEscolheTabelaPreco(blnComPro: Boolean;
                             Var blnPromoc,
                                 blnImpPre: Boolean;
                             Var intPreco : Integer;
                                 blnComPre: Boolean;
                             Var blnPrePro: Boolean;
                             strTitulo: String = ''): Boolean;
begin

  Try
    Result := False;

    pCriarFormularios(TfrmConfirmaPreco, frmConfirmaPreco);
    If (Not fEmptyStr(strTitulo)) Then
    Begin
      frmConfirmaPreco.pnlLayDescri.Visible := True;
      If Pos('-',strTitulo) > 0 Then
      Begin
        frmConfirmaPreco.Caption := frmConfirmaPreco.Caption + ' - ' + Copy(strTitulo, 1, Pos('-', strTitulo)-2);
        frmConfirmaPreco.pnlLayDescri.Caption := Copy(strTitulo, Pos('-', strTitulo)+2, Length(strTitulo));
      End
      Else
      Begin
        frmConfirmaPreco.Caption := frmConfirmaPreco.Caption + ' - ' + strTitulo;
        frmConfirmaPreco.pnlLayDescri.Caption := strTitulo;
      End;
    End;
    {*********************************************************}
    {* VERIFICA SE HABILITA\DESABILITA A OPCAO  DE SEM PRECO *}
    {******************************************************JB*}
    If blnComPre Then
    Begin
      frmConfirmaPreco.rdgOpcao.Items.Clear;
      frmConfirmaPreco.rdgOpcao.Items.Add('Com Preço');
    End;

    {**************************************************}
    {* CASO TENHA FILTRADO ITENS PROMOCIONAL ADICIONA *}
    {* MAIS UMA OPÇÃO NA ESCOLHA DA TABELA DE PREÇO.  *}
    {***********************************************PZ*}
    //If (stlPromoc.Count > 0) Then
    If blnComPro Then
      frmConfirmaPreco.cbTabela.Items.Add('PROMOCIONAL');

    frmConfirmaPreco.chkPrePro.Visible := blnPrePro;

    if (frmConfirmaPreco.chkPrePro.Visible) then
       frmConfirmaPreco.chkPrePro.Checked := (fCfgSis('CHKPRO', varBoolean));

    frmConfirmaPreco.ShowModal;

    If frmConfirmaPreco.ModalResult = mrOk  Then
    Begin
      blnPrePro := frmConfirmaPreco.chkPrePro.Checked;
      Result := True;

      If (frmConfirmaPreco.rdgOpcao.ItemIndex = 1) Or
         (blnComPre)                               Then
      Begin
        If (frmConfirmaPreco.cbTabela.Text = 'PROMOCIONAL') Then
        Begin
          intPreco    := 0;
          blnPromoc := True;
        End
        Else
        Begin
          intPreco    := strToIntDef(RightStr(frmConfirmaPreco.cbTabela.Text, 1), 1);
          blnPromoc := False;
        End;
      End
      Else If frmConfirmaPreco.rdgOpcao.ItemIndex = 0 Then
      Begin
        intPreco  := 0;
        blnImpPre := True;
      End
      Else
      Begin
        intPreco    := 0;
        blnImpPre := False;
      End;
    End
    Else
      Begin
        intPreco    := 0;
        blnImpPre := False;
      End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      intPreco := 0;
      blnImpPre := False;
      pMensagensErro(E.Message, '[pEscolheTabelaPrec]');
    End
  End;

    pFreeAndNil(frmConfirmaPreco);
  End;




Function fRetornaCndPag(var strCodCnd: String;
                        var strCndPag: String;
                        var strNumPar: String): Boolean;

var
  frmCondPagEti: TfrmCondPagEti;
Begin
  pCriarFormularios(TfrmCondPagEti, frmCondPagEti);
  Try
    Try
      Result := True;
      frmCondPagEti.ShowModal;

      strCodCnd := frmCondPagEti.edtCodCnd.Text;
      strCndPag := frmCondPagEti.strCndPag;
      strNumPar := frmCondPagEti.strQtdParcelasCondPgto;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[pEscolheTabelaPreco]');
      End
    End;
  Finally
    pFreeAndNil(frmCondPagEti);
  End;
End;

Function fEscolheTipoEtiqueta(Var tpeTipEti: TTipoEtiqueta;
                                  blnComPro: Boolean;
                              Var blnPromoc: Boolean;
                              Var intTabPre: Integer;
                              Var strCndPag: String;
                              Var strConPag: String;
                              var strNumPar: String;
                              Var strDesSel: String;
                              Var blnPrePro: Boolean;
                                  blnApenasTipoEtiqueta: Boolean = False;
                                  blnDefinirTipoNenhum : Boolean = False): Boolean;
  Var
    strCfgTipEti: String;
    strTipEti: String;
    intOpcFor: Integer;
    blnImpPre: Boolean;
    ArrNomEti: TStringArray;
  Const strEtqPro : String = 'Etiqueta de Produto ';
  procedure pAdicionaTipoNenhum;
  Begin
    If blnDefinirTipoNenhum Then
      pAddDados(ArrNomEti, 'Nenhum');
  End;

Begin
  Result := False;
  intOpcFor := 0;
  strCfgTipEti := fCfgSis('TIPETI');
  strTipEti := '';
  If ((fEmptyStr(strCfgTipEti)) OR (strCfgTipEti = 'S') ) Then
  Begin
    SetLength(ArrNomEti, 0);
    pAddDados(ArrNomEti, 'Laser');
    pAddDados(ArrNomEti, 'Zebra');
    pAddDados(ArrNomEti, 'Argox');
    intOpcFor := fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True);
    Case intOpcFor Of
      1: strCfgTipEti := 'L';
      2: strCfgTipEti := 'Z';
      3: strCfgTipEti := 'A';
    Else
      Exit;
    End;
  End;

  If (strCfgTipEti = 'L') Then
  Begin
    SetLength(ArrNomEti, 0);
    pAddDados(ArrNomEti, strEtqPro + 'Laser padrão' +' - '+ fRetornaLAY_DESCRI(TTipoEtiqueta.GetByName('Laser padrão')));
    pAddDados(ArrNomEti, strEtqPro + 'Laser personalizado' +' - '+ fRetornaLAY_DESCRI(TTipoEtiqueta.GetByName('Laser personalizado')));
    pAdicionaTipoNenhum;

    If Not blnApenasTipoEtiqueta Then
    Begin
      If fCfgSis('CNDETI', varBoolean) Then
        fRetornaCndPag(strCndPag, strConPag, strNumPar);

      If Not fEscolheTabelaPreco(blnComPro,
                                 blnPromoc,
                                 blnImpPre,
                                 intTabPre,
                                 False,
                                 blnPrePro,
                                 'Etiqueta de Produto Laser') Then
        Exit;

      If (blnImpPre) And (intTabPre = 0) Then
      Begin
        tpeTipEti := tpeItensLaserCodBarSPre;
        strDesSel := 'Etiqueta de Produtos Laser Sem Preço';
        Result    := True;
      End;

      If intTabPre <= 0 Then
        Exit;
    end;

    If (fCfgSis('ETIBAR', varBoolean)) Then
    Begin
      intOpcFor := fGetMenu('Escolha o Formato:', ArrNomEti, 1, True, False, 250);

      Case intOpcFor Of
        1: tpeTipEti := tpeItensLaserCodBarPadr;
        2: tpeTipEti := tpeItensLaserCodBarPers;
        3: tpeTipEti := tpeNenhum;
      End;

      If intOpcFor In [1,2] Then
        strDesSel := ArrNomEti[intOpcFor -1];

    End
    Else
    Begin
      If intOpcFor > 2 Then
        tpeTipEti := tpeNenhum
      Else
      Begin
        tpeTipEti := tpeItensLaser;
        strDesSel := strEtqPro + 'Laser';
      End
    End;

  End
  Else

  {****************************}
  {* IMPRESSAO ZEBRA OU ARGOX *}
  {*************************AN*}
  Begin
    If strCfgTipEti = 'A' Then
      strTipEti := 'Argox'
    Else
      strTipEti := 'Zebra';

    SetLength(ArrNomEti, 0);
    pAddDados(ArrNomEti, strEtqPro + strTipEti + ' Gondola Com Preço'   +' - '+ fRetornaLAY_DESCRI(TTipoEtiqueta.GetByName(strTipEti + ' Gondola Com Preço')));
    if ( strCfgTipEti = 'A' ) then     
      pAddDados(ArrNomEti, strEtqPro + strTipEti + ' Gondola Com Preço Layout 1' +' - '+ fRetornaLAY_DESCRI(TTipoEtiqueta.GetByName(strTipEti + ' Gondola Com Preço Layout 1')));
    pAddDados(ArrNomEti, strEtqPro + strTipEti + ' Cód. Barra Com Preço'+' - '+ fRetornaLAY_DESCRI(TTipoEtiqueta.GetByName(strTipEti + ' Cód. Barra Com Preço')));
    pAddDados(ArrNomEti, strEtqPro + strTipEti + ' Cód. Barra Sem Preço'+' - '+ fRetornaLAY_DESCRI(TTipoEtiqueta.GetByName(strTipEti + ' Cód. Barra Sem Preço')));
    pAddDados(ArrNomEti, strEtqPro + strTipEti + ' Gondola Sem Preço'   +' - '+ fRetornaLAY_DESCRI(TTipoEtiqueta.GetByName(strTipEti + ' Gondola Sem Preço')));
    pAdicionaTipoNenhum;
    intOpcFor := fGetMenu('Escolha o Formato:', ArrNomEti, 1, True, False, 250);

    If intOpcFor <= 0 Then
      Exit;

    If ( (intOpcFor = 4) Or (intOpcFor = 5) and ( strCfgTipEti = 'A' ) ) or
       ( (intOpcFor = 3) Or (intOpcFor = 4) and ( strCfgTipEti = 'Z' ) ) Then
      intTabPre:= 1; {Adicionado por conta do erro em que o sistema buscava a tabela de preco zero "0".
                      Como não irá apresentar o preço visualmente passo fixo a informação 1 para buscar a tabpre1}

    If ((intOpcFor in [1, 2])   and ( strCfgTipEti = 'Z' )) or
       ((intOpcFor in [1, 2,3]) and ( strCfgTipEti = 'A' )) Then
    Begin
      blnImpPre := True;

      If Not blnApenasTipoEtiqueta Then
      Begin
        If fCfgSis('CNDETI', varBoolean) Then
          fRetornaCndPag(strCndPag, strConPag, strNumPar);

        If Not fEscolheTabelaPreco(blnComPro,
                                   blnPromoc,
                                   blnImpPre,
                                   intTabPre,
                                   True,
                                   blnPrePro,
                                   ArrNomEti[intOpcFor -1]) Then
          Exit;

        If (intTabPre <= 0) And (Not blnPromoc) Then Exit;
      End;
    End

    Else blnImpPre := False;

    {*********}
    {* ZEBRA *}
    {******AN*}
    If (strCfgTipEti = 'Z') Then
    Begin
      Case intOpcFor Of
        1: tpeTipEti := tpeItensZebraGondolaCPre;
        2: tpeTipEti := tpeItensZebraCodBarCPre;
        3: tpeTipEti := tpeItensZebraCodBarSPre;
        4: tpeTipEti := tpeItensZebraGondolaSPre;
        5: tpeTipEti := tpeNenhum;
      End;

      strDesSel := ArrNomEti[intOpcFor -1];
    End
    Else

    {*********}
    {* ARGOX *}
    {******AN*}
    Begin
      Case intOpcFor Of
        1: tpeTipEti := tpeItensArgoxGondolaCPre;
        2: tpeTipEti := tpeItensArgoxGondolaCPreLayout1;
        3: Begin
             {******************************************}
             {* CASO TENHA ESCOLHIDO A OPÇÃO SEM PREÇO *}
             {* CARREGA A ETIQUETA SEM PREÇO.          *}
             {***************************************PZ*}
             If (blnImpPre) Then
               tpeTipEti := tpeItensArgoxCodBarCPre
             Else
               tpeTipEti := tpeItensArgoxCodBarSPre;
           End;
        4: tpeTipEti := tpeItensArgoxCodBarSPre;
        5: tpeTipEti := tpeItensArgoxGondolaSPre;
        6: tpeTipEti := tpeNenhum;
      End;

      strDesSel := ArrNomEti[intOpcFor -1];
    End;

  End;

  Result := True;
End;

Function fRetornaLAY_DESCRI(tpeTipEtq: TTipoEtiqueta): String;
  Var
    intCodLay: Integer;
    qryLayEti: TUniQuery;
    blnETIEMP: Boolean;
Begin
  qryLayEti := fCriaQuery(Nil);
  Try
    intCodLay := ARR_TIPO_LAYOUT[tpeTipEtq];
    blnETIEMP := fCfgSis('ETIEMP', varBoolean);
    With qryLayEti, SQL Do
    Begin
      Add('SELECT LAY_DESCRI FROM LAYETI');
      Add('WHERE LAY_TIPLAY = :TIPLAY ');
      Add('AND LAY_PADRAO = "S" ');

      If blnETIEMP Then
      Begin
        Add('AND LAY_ETIEMP = "S" ');
        Add('AND LAY_CODEMP = :CODEMP ');
      End;

      ParamByName('TIPLAY').AsInteger := intCodLay;

      If blnETIEMP Then
        ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;
      Result := FieldByName('LAY_DESCRI').AsString;
    End;
    If fEmptyStr(Result) Then
      Result := 'LAYOUT PADRÃO NÃO DEFINIDO';
  Finally
    FreeAndNil(qryLayEti);
  End;
End;

function fRetornaSQLMarcaIte(intQtdEti: Integer; blnUtilizarReplace: Boolean = False): String;
begin
  Result := '';
  Result := Result + '  ' + IIF(blnUtilizarReplace,'REPLACE','INSERT') +' INTO ITEETI                 ';
  Result := Result + ' (ETI_CODOPE, ETI_CODITE, ETI_QTDETI, ETI_AMZETI) ';

  Result := Result + ' SELECT ' + QuotedStr(strLoginUsuarioLogado) + ' AS ETI_CODOPE, ';
  Result := Result + '            CADITE.ITE_CODITE AS ETI_CODITE, ';
  Result := Result +              intToStr(intQtdEti) + ' AS ETI_QTDETI, ';
  Result := Result + '            NULL AS ETI_AMZETI  ';

  Result := Result + ' FROM CADITE                         ';
end;

Function fRetornaSQLDesmarcaIte: String;
  Var
    strUpdIte: String;
Begin
  strUpdIte := '';
  strUpdIte := strUpdIte + ' DELETE FROM ITEETI WHERE ETI_CODOPE = ' + QuotedStr(strLoginUsuarioLogado) + ' ';

  Result    := strUpdIte;
End;


end.
