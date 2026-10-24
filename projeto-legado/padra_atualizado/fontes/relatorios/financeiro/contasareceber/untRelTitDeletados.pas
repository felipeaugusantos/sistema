unit untRelTitDeletados;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  Uni, AppEvnts, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  untGeraExcel, Data.DB, untExcel;

type
  TfrmRelTitDeletados = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    chkLisCtaRec: TCheckBox;
    gpbStatus: TGroupBox;
    lbl1: TColorLabel;
    edtStatus: TEditFocus;
    shpOpe: TShape;
    gpbOrdem: TGroupBox;
    ColorLabel5: TColorLabel;
    edtOrdem: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    blnLiberado: Boolean;

    qryRelatorio: TUniQuery;

    procedure pCriaQryRelatorio;

    procedure pGravaImpressos;
    procedure pVerdeVermelho;
    function fGeraExcel : Boolean;
    function fRetDuplic: String;
    procedure pOnSomaReumo(var Totais: TTotais; Dados: TDataSet);
    procedure pOnMontaResumo(Excel: TExcel; Campos: TCampos;
      Quebra: TRecQuebras);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelTitDeletados: TfrmRelTitDeletados;

implementation

uses untQckTitDeletados, untFuncoesFactory, untTypesSistema, untIFuncoes;

{$R *.dfm}

procedure TfrmRelTitDeletados.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  
  inherited;

  blnLiberado := fVerificaAcessoSistema('RELTDI');
  pVerdeVermelho;
end;

procedure TfrmRelTitDeletados.btnImprimirClick(Sender: TObject);
  Var
    strSQL     : String;
    qryGenDel  : TUniQuery;
    blnTbCaixa1: Boolean;
begin
  inherited;

  blnTbCaixa1 := False ;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  Application.ProcessMessages;

  qryGenDel := fCriaQuery(Self);

  If blnImprime Then
  Begin
    if fTabelaExiste('DEL_CADREC') then blnTbCaixa1 := true;

    If blnTbCaixa1 Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE        ';
      strSQL := strSQL + '  "DELC" AS TAB,           ';
      strSQL := strSQL + '  D.DTADEL,                ';
      strSQL := strSQL + '  D.HORDEL,                ';
      strSQL := strSQL + '  D.OPEDEL,                ';
      strSQL := strSQL + '  D.AUTOINCREM,            ';
      strSQL := strSQL + '  D.CTR_NOMFRM,            ';
      strSQL := strSQL + '  D.CTR_DTAVEN,            ';
      strSQL := strSQL + '  D.CTR_NUMDUP,            ';
      strSQL := strSQL + '  D.CTR_PARCEL,            ';
      strSQL := strSQL + '  D.CTR_ESPDOC,            ';
      strSQL := strSQL + '  D.CTR_CODEMP,            ';
      strSQL := strSQL + '  D.CTR_CODVEN,            ';
      strSQL := strSQL + '  D.CTR_CODCLI,            ';
      strSQL := strSQL + '  D.CTR_HIST01,            ';
      strSQL := strSQL + '  D.CTR_DTACAD,            ';
      strSQL := strSQL + '  D.CTR_VALDUP,            ';
      strSQL := strSQL + '  CLI_NOMCLI               ';
      strSQL := strSQL + 'FROM                       ';
      strSQL := strSQL + '  DEL_CADREC D,            ';
      strSQL := strSQL + '  CADCLI                   ';
      strSQL := strSQL + 'WHERE                      ';
      strSQL := strSQL + '  D.DTADEL BETWEEN :DTAINI AND :DTAFIN AND ';
      strSQL := strSQL + '  CLI_CODCLI = D.CTR_CODCLI                ';

      If edtStatus.Text = 'S' Then
        strSQL := strSQL + '  AND ( D.IMPRES <> "S" OR D.IMPRES IS NULL ) ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '  AND D.CTR_CODEMP = :CODEMP '
      Else
        strSQL := strSQL + '  AND LOCATE(D.CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      If (chkLisCtaRec.Checked) Then
        strSQL := strSQL + ' AND D.CTR_NOMFRM = :NOMFRM ';

      strSQL := strSQL + 'ORDER BY       ';

      If edtOrdem.Text = 'D' Then
        strSQL := strSQL + '  DTADEL, HORDEL '
      Else
        strSQL := strSQL + '  CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP ';

      With qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

        If (chkLisCtaRec.Checked) Then
          ParamByName('NOMFRM').AsString := 'frmCadCtaReceber';

        Open;
      End;

      If Not qryRelatorio.IsEmpty Then
      Begin
        If edtDestino.Text <> 'E' then
        Begin
          Try
            pCriarFormularios(TfrmQckTitDeletados,frmQckTitDeletados);

            frmQckTitDeletados.dtsRelatorio.DataSet := qryRelatorio;

            frmQckTitDeletados.rllNomeRelatorio.Caption := 'RELATORIO DE TITULOS DELETADOS ';

            If strTipImp = 'M' Then
              frmQckTitDeletados.qckPagina.DefaultFilter := rldFiltro
            Else
              frmQckTitDeletados.qckPagina.DefaultFilter := Nil;
            frmQckTitDeletados.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

            If Not fEmptyStr(edtCodEmpresa.Text) Then
              frmQckTitDeletados.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + '-' + edtDesEmpresa.Text
            Else
              frmQckTitDeletados.rllEmpresa.Caption := 'EMPRESA: TODAS';

            If edtStatus.Text = 'S' then
              frmQckTitDeletados.rllStatus.Caption := 'STATUS: SOMENTE OS NÃO IMPRESSOS'
            Else
              frmQckTitDeletados.rllStatus.Caption := 'STATUS: TODOS OS REGISTROS';

            frmQckTitDeletados.rllListar.Caption := 'LISTAR SOMENTE AS DELETADAS PELA MANUTENÇÃO DO CONTAS A RECEBER: '+ IfThen(chkLisCtaRec.Checked, 'SIM', 'NÃO');

            If edtOrdem.Text = 'D' then
              frmQckTitDeletados.rllOrdenacao.Caption := 'ORDENAR POR: DATA/HORA DA DELEÇÃO'
            Else
             frmQckTitDeletados.rllOrdenacao.Caption := 'ORDENAR POR: NÚMERO DE DUPLICATA';

            If edtDestino.Text = 'V' Then
              frmQckTitDeletados.qckPagina.PreviewModal
            Else
              frmQckTitDeletados.qckPagina.Print;
          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
            End;
          End;

          pFreeAndNil(frmQckTitDeletados);
        End
        Else
          fGeraExcel;

        If edtStatus.Text = 'S' Then
          pGravaImpressos;
      End
      Else
      Begin
        pTabelaVazia;
      End;
    End
    Else
    Begin
      pTabelaVazia;
    End;

    pSetFocus(mskDtaIni);

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

  FreeAndNil(qryGenDel);

end;

function TfrmRelTitDeletados.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End
    Else If (Sender = edtStatus) Then
    Begin

      If fEmptyStr(edtStatus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O filtro Status deve ser informado!', ['&O k']);
        Result := False;
      End
      Else If Pos(edtStatus.Text, 'ST') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O filtro Status deve ser S ou T!', ['&O k']);
        Result := False;
      End
      Else If (Not blnLiberado) And (edtStatus.Text = 'T') Then
      Begin
        fMensagem('ATENÇÃO!', 'O usuário não tem direito de acesso à esta opção!', ['&O k']);
        edtStatus.Text := 'S';
        Result := False;
      End;

    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = edtOrdem) Then
    Begin

      If Pos(edtOrdem.Text, 'D_N') <= 0 Then
      Begin
        fMensagem('', 'O campo Ordenar por deve ser D ou N!', ['&O k']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelTitDeletados.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelTitDeletados.FormCreate(Sender: TObject);
begin
  inherited;
  blnExcel := True;
end;

procedure TfrmRelTitDeletados.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelTitDeletados.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelTitDeletados.fRetDuplic : String;
begin
  Result := qryRelatorio.FieldByName('CTR_NUMDUP').AsString +
            qryRelatorio.FieldByName('CTR_PARCEL').AsString + '-' +
            qryRelatorio.FieldByname('CTR_ESPDOC').AsString + '-' +
            qryRelatorio.FieldByname('CTR_CODEMP').AsString;
End;

procedure TfrmRelTitDeletados.pOnSomaReumo(Var Totais: TTotais; Dados: TDataSet);
Begin
  Totais['CTR_VALDUP'] := Totais['CTR_VALDUP'] + Dados.FieldByName('CTR_VALDUP').AsFloat;
End;

procedure TfrmRelTitDeletados.pOnMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    ProximaLinha;

    Escrever(LinhaAtual, Campos.ColunaPorNome['CTR_DTACAD'].Coluna , 'TOTAL:');
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['CTR_VALDUP'].Coluna);
    Alinhamento(LinhaAtual, Campos.ColunaPorNome['CTR_VALDUP'].Coluna, Direita);
    Escrever(LinhaAtual, Campos.ColunaPorNome['CTR_VALDUP'].Coluna, Quebra.Totais.Campo['CTR_VALDUP']);

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
  End;

end;

function TfrmRelTitDeletados.fGeraExcel: Boolean;
  Var
    objExcel : TGeraExcel;
begin
  objExcel := TGeraExcel.Create(qryRelatorio, Nil);
  Try
    With objExcel Do
    Begin
      strNomRel := 'RELATORIO DE TITULOS DELETADOS';

      AddFiltro('REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        AddFiltro('EMPRESA: ' + edtCodEmpresa.Text + '-' + edtDesEmpresa.Text)
      Else
        AddFiltro('EMPRESA: TODAS');

      if edtStatus.Text = 'S' then
        AddFiltro('STATUS: SOMENTE OS NÃO IMPRESSOS')
      Else
        AddFiltro('STATUS: TODOS OS REGISTROS');

      AddFiltro('LISTAR SOMENTE AS DELETADAS PELA MANUTENÇÃO DO CONTAS A RECEBER: '+ IfThen(chkLisCtaRec.Checked, 'SIM', 'NÃO'));

      if edtOrdem.Text = 'D' then
        AddFiltro('ORDENAR POR: DATA/HORA DA DELEÇÃO')
      Else
       AddFiltro('ORDENAR POR: NÚMERO DE DUPLICATA');

      AddCampo('DTADEL','DATA DEL.');
      AddCampo('HORDEL','HORA DEL.');
      AddCampo('OPEDEL','OPERADOR');
      AddCampo('CTR_DTAVEN','DATA VENC.');
      AddCampo(fRetDuplic, 'DUPLIC','DUPLICATA');
      AddCampo('CTR_CODVEN','VENDEDOR');
      AddCampo('CTR_CODEMP','EMPRESA');
      AddCampo('CTR_CODCLI','CÓD. CLIENTE');
      AddCampo('CLI_NOMCLI','CLIENTE');
      AddCampo('CTR_DTACAD','DATA CAD.');
      AddCampo('CTR_VALDUP','VALOR');
      AddCampo('CTR_HIST01','HISTÓRICO');
      AddCampo('CTR_NOMFRM','ORIGEM');

      AddTotais('CTR_VALDUP');

      OnSomaResumo  := pOnSomaReumo;
      OnMontaResumo := pOnMontaResumo;

      Result := fGerarRelatorio;

      if Result then
        fMensagem('','Arquivo Gerado com Sucesso!', ['&OK']);

    End;
  Finally
    FreeAndNil(objExcel);
  End;
end;

procedure TfrmRelTitDeletados.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODAS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;
end;

procedure TfrmRelTitDeletados.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelTitDeletados.pGravaImpressos;
  Var strSQL: String;
      qryDel: TUniQuery;
begin
  qryDel := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'UPDATE DEL_CADREC   ';
  strSQL := strSQL + '   SET IMPRES = "S" ';
  strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

  qryDel.Close;
  qryDel.SQL.Clear;
  qryDel.SQL.Add(strSQL);

  With qryRelatorio do
  Begin
    First;
    While Not Eof Do
    Begin
      If SameText(FieldByName('TAB').AsString, 'DELC') Then
      Begin
        qryDel.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
        qryDel.ExecSQL;
      End;
      Next;
    End;
  End;

  FreeAndNil(qryDel);
end;

procedure TfrmRelTitDeletados.pVerdeVermelho;
Begin
  If (Not blnLiberado) Then
       shpOpe.Brush.Color  := clRed
  Else shpOpe.Brush.Color  := clGreen;
End;

end.

