unit untRelCtrBordero;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, StrUtils,
  QColorLabel, ExtCtrls, Buttons, Mask, MaskEditFocus,
  DB,   Uni, BitBtnLockedIncrem, frxExportCSVTestabilidade, untIFuncoes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar;

type
  TfrmRelCtrBordero = class(TfrmPaiRelatorio)
    lbl1: TLabel;
    lblDtaIni: TLabel;
    lblDtaFin: TLabel;
    lbl2: TLabel;
    grpTipoData: TGroupBox;
    lbl3: TColorLabel;
    edtTipoDta: TEditFocus;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    lblPortador: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    frxRelatorioM: TfrxReport;
    frxRelatorioJ: TfrxReport;
    lblBanco: TLabel;
    edtBanco: TEditFocus;
    edtDesBanco: TEditFocus;
    frxRelatBBJ: TfrxReport;
    frxCadEmp: TfrxDBDataset;
    edtDtaIni: TcxDateEdit;
    edtDtaFin: TcxDateEdit;
    procedure edtTipoDtaExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtBancoKeyPress(Sender: TObject; var Key: Char);
    procedure edtBancoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;

    strLinCli: String;
    strLinPor: String;
    strLinEmp: String;

    procedure pCriaQryRelatorio;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public
    { Public declarations }
    arrLinPor: TConsultasArray;
    arrLinCli: TConsultasArray;
    arrLinEmp: TConsultasArray;
  end;

implementation

{$R *.dfm}

uses untPai, untClassPanelCx, untFuncoesSimples, untConsultas, untFuncoes, untCfgRel,
      untFuncoesRelatorios, untFuncoesConsulta, untPesqAux;

function TfrmRelCtrBordero.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = edtDtaIni) Or (Sender = edtDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(edtDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = edtDtaFin) Then
          Sender := edtDtaIni;
      End
      Else
      Begin
        If (Sender = edtDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(edtDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(edtDtaIni.Text) > StrToDate(edtDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End
    Else If (Sender = edtTipoDta) Then
    Begin

      If fEmptyStr(edtTipoDta.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo tipo de data deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If (edtTipoDta.Text <> 'V') And (edtTipoDta.Text <> 'C') Then
      Begin
        fMensagem('ATENÇÃO','O campo tipo de data deve conter somente C ou V!',['&O K']);
        Result := False;
      End;

    End

    {*****************************}
    {* VALIDA O CÓDIGO DO BANCO  *}
    {**************************IV*}
    Else If (Sender = edtBanco) Then
    Begin

      If Not fEmptyStr(edtBanco.Text) Then
      Begin
        edtDesBanco.Text := fRetNomeBancoSelec(edtBanco.Text);
        If fEmptyStr(edtDesBanco.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Banco não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesBanco.Text := 'PADRÃO';
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      pDesmarcaLista(edtCodEmp, arrLinEmp);

      If Not fEmptyStr(edtCodEmp.Text) And (edtCodEmp.Text <> '000') Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtDestino.Text, 'V_I_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V ou I!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = edtCodPor Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin

        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        edtDesPor.Text;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelCtrBordero.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;

end;

procedure TfrmRelCtrBordero.edtTipoDtaExit(Sender: TObject);
begin
  inherited;

  If edtTipoDta.Text = 'C' Then
  Begin
    lblDtaIni.Caption := '(CADASTRO)';
    lblDtaFin.Caption := '(CADASTRO)';
  End
  Else
  Begin
    lblDtaIni.Caption := '(VENCIMENTO)';
    lblDtaFin.Caption := '(VENCIMENTO)';
  End;

end;

procedure TfrmRelCtrBordero.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrLinCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrBordero.edtCodCliExit(Sender: TObject);
begin
  inherited;

  If Not edtCodCli.ReadOnly Then
    pEdtCodSelectExit(edtCodCli, edtDesCli, arrLinCli, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmRelCtrBordero.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrLinEmp, False, True) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrBordero.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrLinEmp, fRetNomeEmpresa, Nil, 'da Empresa');
end;

procedure TfrmRelCtrBordero.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPor,
                   nil,
                   Key,
                   arrLinPor,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
  Begin
    If fValidaCampos(edtCodPor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrBordero.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;

  {***********************************}
  {* EXIBE O SHAPE Q IDENTIFICA SE O *}
  {* RELATÓRIO POSSUI CONSULTAS COM  *}
  {* MULTISELEÇÃO                    *}
  {***31/03/2010*******************IV*}
  shpMultSel.Visible := True;

  edtDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  edtDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);

  inherited;
end;

procedure TfrmRelCtrBordero.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtTipoDta);
end;

procedure TfrmRelCtrBordero.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtrBordero.btnImprimirClick(Sender: TObject);
  Var
    strSQL       : String;
    frxRel       : TfrxReport;
    intCor       : Integer;
    intCont      : Integer;
    qryCadEmpresa: TUniQuery;
    qrySocios    : TUniQuery;
    strRetBco    : String;
    intRetCar    : Integer;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  intCor := StrToIntDef(fCfgSis('CORZEB'), clWhite);
  inherited;

  qryCadEmpresa := fCriaQuery;
  qrySocios     := fCriaQuery;

  If blnImprime Then
  Begin
    Application.ProcessMessages;

    {***********************************}
    {* MONTA QUERY DO CADASTRO EMPRESA *}
    {********************************IV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP, ';
    strSQL := strSQL + '  CONCAT(EMP_ENDERE,", ",EMP_ENDNUM) EMP_ENDERE, ';
    strSQL := strSQL + '  EMP_C_E_P_, ';
    strSQL := strSQL + '  EMP_C_G_C_, ';
    strSQL := strSQL + '  CID_NOMCID, ';
    strSQL := strSQL + '  CID_ESTADO  ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '  CADEMP, ';
    strSQL := strSQL + '  CADCID  ';
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '  EMP_CODCID = CID_CODCID  ';
    strSQL := strSQL + '  AND EMP_CODEMP = :CODEMP ';

    With qryCadEmpresa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    frxCadEmp.DataSet := qryCadEmpresa;

    {***********************************}
    {* MONTA QUERY  CADASTRO DE SOCIOS *}
    {********************************IV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE  ';
    strSQL := strSQL + '  SOC_NOMSOC,        ';
    strSQL := strSQL + '  SOC_PROFIS,        ';
    strSQL := strSQL + '  CASE SOC_ESTCIV    ';
    strSQL := strSQL + '    WHEN "C" THEN "CASADO"       ';
    strSQL := strSQL + '    WHEN "S" THEN "SOLTEIRO"     ';
    strSQL := strSQL + '    WHEN "O" THEN "OUTRO"        ';
    strSQL := strSQL + '    WHEN "M" THEN "MARITALMENTE" ';
    strSQL := strSQL + '  END AS SOC_ESTCIV, ';
    strSQL := strSQL + '  CONCAT(CID_NOMCID,"-",CID_ESTADO) AS SOC_CIDADE, ';
    strSQL := strSQL + '  SOC_NUMR_G, ';
    strSQL := strSQL + '  SOC_ORGEMI, ';
    strSQL := strSQL + '  SOC_NUMCPF  ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '  CADSOC  ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = SOC_CIDSOC ';
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '  SOC_CODEMP = :CODEMP ';
    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '  SOC_CODSOC  ';

    With qrySocios Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    {***********************************}
    {* MONTA QUERY  PRINCIPAL          *}
    {********************************IV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  R.CTR_DTAVEN, ';
    strSQL := strSQL + '  R.CTR_DTACAD, ';
    strSQL := strSQL + '  R.CTR_CODEMP, ';
    strSQL := strSQL + '  R.CTR_CODCLI, ';
    strSQL := strSQL + '  R.CTR_VALDUP, ';
    strSQL := strSQL + '  R.CTR_VALORI, ';
    strSQL := strSQL + '  R.CTR_NUMDUP, ';
    strSQL := strSQL + '  R.CTR_PARCEL, ';
    strSQL := strSQL + '  R.CTR_ESPDOC, ';
    strSQL := strSQL + '  CONCAT(R.CTR_NUMDUP, "-", R.CTR_PARCEL, "-", R.CTR_ESPDOC) AS NUMDUP, ';
    strSQL := strSQL + '  P.POR_NOMPOR AS NOMPOR, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_CGCCPF, ';
    strSQL := strSQL + '  C.CLI_C_G_C_, ';
    strSQL := strSQL + '  CONCAT(D.CID_NOMCID, " - ", D.CID_ESTADO) AS CLI_NOMCID, ';
    strSQL := strSQL + '  C.CLI_DTACAD AS DTACAD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC R ';
    strSQL := strSQL + '  LEFT JOIN CADCLI C ON R.CTR_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADCID D ON D.CID_CODCID = C.CLI_CODCID ';
    strSQL := strSQL + '  LEFT JOIN CADPOR P ON P.POR_CODPOR = R.CTR_CODPOR ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '    CTR_DTAREC IS NULL AND  ';

    If edtTipoDta.Text = 'C' Then
      strSQL := strSQL + '  CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + fStrLocate(edtCodCli, arrLinCli, 'CTR_CODCLI', 'CODCLI');

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrLinPor, 'CTR_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    strSQL := strSQL + fStrLocate(edtCodEmp, arrLinEmp, 'CTR_CODEMP', 'CODEMP');

    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + ' R.CTR_NUMDUP, R.CTR_PARCEL, R.CTR_ESPDOC, C.CLI_NOMCLI ';

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(edtDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(edtDtaFin.Text);

      pSetaParam(edtCodCli.Text, arrLinCli, strLinCli, 'CODCLI', qryRelatorio);

      If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrLinPor, strLinPor, 'CODPOR', qryRelatorio);

      pSetaParam(edtCodEmp.Text, arrLinEmp, strLinEmp, 'CODEMP', qryRelatorio);

      Open;

    End;

    If Not qryRelatorio.IsEmpty Then
    Begin

      If (Not fEmptyStr(edtBanco.Text)) And (edtBanco.Text = '001') Then
      Begin

        If fVer_Banco_Carteira(edtBanco.Text, '', strRetBco, intRetCar) Then
        Begin

          frxRel := frxRelatBBJ;
          frxRel.DotMatrixReport           := False;
          frxRel.PrintOptions.PrintMode    := pmScale;
          frxRel.PrintOptions.PrintOnSheet := 9;

          frxRel.Script.Variables['DTACONV'] := fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'DTACONV', '');
          frxRel.Script.Variables['CODCONV'] := fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'CODCONV', '');
          frxRel.Script.Variables['CODAGEN'] := fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'CODAGEN', '') +
                                          '-' + fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'DIGAGEN', '');
          frxRel.Script.Variables['NOMAGEN'] := fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NOMAGEN', '');
          frxRel.Script.Variables['CDCONTA'] := fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'NUMCTAC', '') +
                                          '-' + fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'DIGCTAC', '');

          With qrySocios Do
          Begin
            First;
            For intCont := 1 to 2 do
            Begin
               If Eof Then
               Begin
                 frxRel.Script.Variables['NOMSOC'+IntToStr(intCont)] := '';
                 frxRel.Script.Variables['PROFIS'+IntToStr(intCont)] := '';
                 frxRel.Script.Variables['ESTCIV'+IntToStr(intCont)] := '';
                 frxRel.Script.Variables['CIDADE'+IntToStr(intCont)] := '';
                 frxRel.Script.Variables['NUM_RG'+IntToStr(intCont)] := '';
                 frxRel.Script.Variables['ORGEMI'+IntToStr(intCont)] := '';
                 frxRel.Script.Variables['NUMCPF'+IntToStr(intCont)] := '';
               End
               Else
               Begin
                 frxRel.Script.Variables['NOMSOC'+IntToStr(intCont)] := FieldByName('SOC_NOMSOC').AsString;
                 frxRel.Script.Variables['PROFIS'+IntToStr(intCont)] := FieldByName('SOC_PROFIS').AsString;
                 frxRel.Script.Variables['ESTCIV'+IntToStr(intCont)] := FieldByName('SOC_ESTCIV').AsString;
                 frxRel.Script.Variables['CIDADE'+IntToStr(intCont)] := FieldByName('SOC_CIDADE').AsString;
                 frxRel.Script.Variables['NUM_RG'+IntToStr(intCont)] := FieldByName('SOC_NUMR_G').AsString;
                 frxRel.Script.Variables['ORGEMI'+IntToStr(intCont)] := FieldByName('SOC_ORGEMI').AsString;
                 frxRel.Script.Variables['NUMCPF'+IntToStr(intCont)] := FieldByName('SOC_NUMCPF').AsString;
               End;

               If Not Eof Then Next;
            End;
          End;

          Try

            If edtDestino.Text = 'V' Then
              pPreviewReport(Self.Name, Self.Caption, frxRel)
            Else If edtDestino.Text = 'I' Then
            Begin
              If frxRel.PrepareReport Then
                pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
            End;

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
            End;

          End;

        End;

      End
      Else
      Begin

        {******************************************************}
        {* DEFINE SE O RELATORIO É MATRICIAL OU JATO DE TINTA *}
        {***************************************************JB*}
        If SameText(strTipImp, 'M') Then
        Begin
          frxRel := frxRelatorioM;
        End
        Else
        Begin
          frxRel := frxRelatorioJ;
          frxRel.DotMatrixReport           := False;
          frxRel.PrintOptions.PrintMode    := pmScale;
          frxRel.PrintOptions.PrintOnSheet := 9;
          TfrxMemoView(frxRel.FindObject('Memo3')).Highlight.Color := intCor;
        End;

        Try
          {******************************}
          {* CARREGA CABEÇALHO          *}
          {***************************JB*}
          frxRel.Script.Variables['NOMREL'] := 'RELATORIO DE BORDERÔ PARA DESCONTO DE TÍTULOS ';

          frxRel.Script.Variables['PERIODO'] := IfThen( fEmptyStr(fTiraCaracEspeciais(edtDtaIni.Text)), '',
                                                     'REFERENTE AO PERIODO '+ lblDtaIni.Caption + ' DE ' +
                                                     FormatDateTime('dd/mm/yyyy',StrToDate(edtDtaIni.Text)) +
                                                     ' A ' + FormatDateTime('dd/mm/yyyy',StrToDate(edtDtaFin.Text)));

          If Length(arrLinCli) > 1 Then
            frxRel.Script.Variables['FILCLI'] := 'CLIENTE: (+1) VÁRIOS SELECIONADOS'
          Else
            frxRel.Script.Variables['FILCLI'] := fStrTitulo(edtCodCli.Text, edtDesCli, arrLinCli, strLinCli, 'CLIENTE');

          frxRel.Script.Variables['FILPOR'] := fStrTitulo(edtCodPor.Text, edtDesPor, arrLinPor, strLinPor, 'PORTADOR');
          frxRel.Script.Variables['FILEMP'] := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrLinEmp, strLinEmp, 'EMPRESA');

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frxRel)
          Else If edtDestino.Text = 'I' Then
          Begin
            If frxRel.PrepareReport Then
              pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
          End;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;

        End;

      End;

    End
    Else
      pTabelaVazia;

    Self.SelectFirst;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  FreeAndNil(qryCadEmpresa);
  FreeAndNil(qrySocios);  
  pSetFocus(edtTipoDta);

end;

procedure TfrmRelCtrBordero.edtBancoKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqBanco(Self, edtBanco, edtDesBanco, nil, Key, arrSel) Then  
  Begin
    If fValidaCampos(edtBanco,False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtrBordero.edtBancoExit(Sender: TObject);
begin
  inherited;

//  pEdtCodSelectExit(edtBanco, edtDesBanco, arrLinBco, Nil, fRetNomeBancoSelec, 'do Banco');
end;

end.
