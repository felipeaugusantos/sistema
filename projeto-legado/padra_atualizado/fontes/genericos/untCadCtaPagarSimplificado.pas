unit untCadCtaPagarSimplificado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, StrUtils,
  EditFocus, Vcl.DBCtrls, DBEditFocus, Data.DB, Uni, untFechamentoFinanceiro;

type
  TfrmCadCtaPagarSimplificado = class(TfrmPaiCad)
    pnlGeral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label15: TLabel;
    dbeNumDup: TDBEditFocus;
    dbeParcel: TDBEditFocus;
    dbeCodEmp: TDBEditFocus;
    dbeCodFor: TDBEditFocus;
    dbeSerie: TDBEditFocus;
    edtNomEmp: TEditFocus;
    edtNomFor: TEditFocus;
    pnlDetalhe: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbeDtaCad: TDBEditFocus;
    dbeDtaVen: TDBEditFocus;
    dbeValDup: TDBEditFocus;
    dtsTabela: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeValDupExit(Sender: TObject);
    procedure dbeValDupEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    qryConEmp,
    qryConFor: TUniQuery;
    objFechamento: TFechamentoFinanceiro;

    AValorTotalInicial: Double;
    AValorTotal: Double;
    ADataCadastroInicial: TDateTime;
    AEmpresaInicial: String;

    fltValDupAnt: Double;
    fltValOriAnt: Double;

    blnDupTravada: Boolean;
    strAutoincremLckAtc: String;

    procedure pCarregaEmpresa;
    procedure pCarregaFornecedor;

    procedure pAfterOpen(DataSet: TDataSet);

    procedure pGravaLogCtp(strNumDup,
                           strParcel: String;
                           intSeqBai: Integer;
                           strCodEmp,
                           strCodFor,
                           strSerie_: String;
                           blnInserindo: Boolean);

    procedure AdicionaDisplayFormatFloatField(ADataset: TDataset;
                                              ANomeCampo,
                                              AMascara: String);

  protected

    procedure pInicializaIndices; override;
    procedure pDestravarRegistros;  override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

    strAutoIncrem: String;
  end;

var
  frmCadCtaPagarSimplificado: TfrmCadCtaPagarSimplificado;

implementation

{$R *.dfm}

uses untFuncoesSimples, untPesqAux, untConstantes, untTCadPag,
  untTCadPagRepository, untLogCtp, untFuncoes;

procedure TfrmCadCtaPagarSimplificado.AdicionaDisplayFormatFloatField(
  ADataset: TDataset; ANomeCampo, AMascara: String);
begin
  If ADataSet.FindField(ANomeCampo) <> nil Then
    TFloatField(ADataSet.FieldByName(ANomeCampo)).DisplayFormat := AMascara;
end;

procedure TfrmCadCtaPagarSimplificado.btnAlterarClick(Sender: TObject);
Var
    blnPodeAlterar: Boolean;
begin
  blnPodeAlterar := True;

  If Not (fCfgSis('EMPGER', varBoolean)) Then
  Begin
    If (Not fEmptyStr(dbeCodEmp.Text)) Then
    Begin
      If dbeCodEmp.Text = VS_strCodEmp Then
        blnPodeAlterar := True
      Else
        blnPodeAlterar := False;
    End;
  End;

  If blnPodeAlterar Then
  Begin
    If Not blnDupTravada Then
    Begin
      fLock_Unlock(strNomeTabela +
                   qryTabela.FieldByName('AUTOINCREM').AsString,
                   True,
                   False);

      strAutoIncremLckAtc := qryTabela.FieldByName('AUTOINCREM').AsString;
      blnDupTravada       := True;
    end;

    inherited;
    If blnAlterou Then
    Begin

      {*****************************************************}
      {* SÓ PODE ALTERAR O VALDUP SE TEM DIREITO DE ACESSO *}
      {**************************************************JU*}
      If Not fVerificaAcessoSistema('CTPALTVLR') Then
      Begin
        dbeValDup.Enabled := False;
      End;

      pHabilitaCodigo(dbeNumDup, dbeDtaVen, False);
      dbeParcel.Enabled := False;
      dbeCodEmp.Enabled := False;
      dbeCodFor.Enabled := False;
      dbeSerie.Enabled  := False;
      dbeDtaCad.Enabled := False;

    End;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Uma Empresa Não Gerencial só pode alterar Duplicatas por ela Gerada!', ['&O k']);
  End;
end;

procedure TfrmCadCtaPagarSimplificado.btnGravarClick(Sender: TObject);
  Var
    blnInserindo : Boolean;
    blnSaveUsaPr : Boolean;
    strOldDup,
    strOldEmp    : String;

begin
  If Not fVerificaCampos Then
    Exit;

  blnInserindo := qryTabela.State = dsInsert;

  If Not blnInserindo Then
  Begin
    If qryTabela.FieldByName('CTP_NUMDUP').OldValue <> dbeNumDup.Text Then
      strOldDup := qryTabela.FieldByName('CTP_NUMDUP').OldValue;
    If qryTabela.FieldByName('CTP_CODEMP').OldValue <> dbeCodEmp.Text Then
      strOldEmp := qryTabela.FieldByName('CTP_CODEMP').OldValue;
  End;

  blnSaveUsaPr := blnUsaProCodigo;

  If fEmptyStr(dbeNumDup.Text) Then
    qryTabela.FieldByName('CTP_NUMDUP').AsString := fRetSequencialCadPag
  Else
    blnUsaProCodigo := FALSE;

  qryTabela.FieldByName('CTP_EMPGER').AsString := dbeCodEmp.Text + '/';

  If fEmptyStr(dbeSerie.Text) Then
    qryTabela.FieldByName('CTP_SERIE_').AsString := '';

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  inherited;

  blnUsaProCodigo := blnSaveUsaPr;

  If Not blnGravou Then
  Begin
    fRollBack;
    Exit;
  End;

  Try
    {**********************************************}
    {* CASO GRAVOU, GRAVA A TABELA CTPDET, LOGCTP *}
    {****************************************MV,BB*}
    pGravaLogCtp(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                 qryTabela.FieldByName('CTP_PARCEL').AsString,
                 qryTabela.FieldByName('CTP_SEQBAI').AsInteger,
                 qryTabela.FieldByName('CTP_CODEMP').AsString,
                 qryTabela.FieldByName('CTP_CODFOR').AsString,
                 qryTabela.FieldByName('CTP_SERIE_').AsString,
                 blnInserindo);

    fCommit;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  If blnInserindo Then
  begin
    fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, True);
    blnDupTravada       := True;
    strAutoincremLckAtc := qryTabela.FieldByName('AUTOINCREM').AsString;
  end;

  blnGravou := False;
  pSetFocus(Self);

end;

procedure TfrmCadCtaPagarSimplificado.dbeValDupEnter(Sender: TObject);
begin
  inherited;
  If (dbeValDup.Field Is TFloatField) Then
    dbeValDup.Text := AnsiReplaceStr(dbeValDup.Text,'.','');
end;

procedure TfrmCadCtaPagarSimplificado.dbeValDupExit(Sender: TObject);
begin
  inherited;
  //FECHAMENTO FINANCEIRO
  //SE O VALOR TOTAL FOR ALTERADO VERIFICA FECHAMENTO
  if (qryTabela.State = dsEdit) And
     (AValorTotalInicial <> AValorTotal) Then
  begin
    if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, qryTabela.FieldByName('CTP_DTACAD').AsDateTime) then
      Exit;
  end;
end;

procedure TfrmCadCtaPagarSimplificado.FormCreate(Sender: TObject);
begin
  inherited;
  strAutoIncrem := '';
  strNomeCampo  := 'CTP_NUMDUP';
  strNomeTabela := 'CADPAG';

  qryTabela             := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
  qryTabela.AfterOpen   := pAfterOpen;
  //qryTabela.AfterScroll := pAfterScroll;
  dtsTabela.DataSet     := qryTabela;

  SetLength(arrCamposChave, 5);
  arrCamposChave[0] := dbeNumDup;
  arrCamposChave[1] := dbeParcel;
  arrCamposChave[2] := dbeCodEmp;
  arrCamposChave[3] := dbeCodFor;
  arrCamposChave[4] := dbeSerie;

  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  objFechamento := TFechamentoFinanceiro.Create(Self, Self.Name);
end;

procedure TfrmCadCtaPagarSimplificado.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_ESCAPE then
  begin
    if qryTabela.State = dsBrowse then
      btnSair.Click;
  end;
end;

procedure TfrmCadCtaPagarSimplificado.FormShow(Sender: TObject);
begin
  inherited;

  blnDupTravada := False;
  strAutoincremLckAtc := '';

  if Not fEmptyStr(strAutoIncrem) Then
  Begin
    qryTabela             := fCriarQuery('SELECT * FROM CADPAG WHERE AUTOINCREM = ' + QuotedStr(strAutoIncrem)+ ' ', Self);
    qryTabela.AfterOpen   := pAfterOpen;
    //qryTabela.AfterScroll := pAfterScroll;
    dtsTabela.DataSet     := qryTabela;
    qryTabela.Open;

    If fEmptyStr(qryTabela.FieldByName('CTP_DTAPAG').AsString) And
      ((qryTabela.RecordCount >= 1) Or (qryTabela.State = dsInsert)) Then
    Begin
      AValorTotal := (qryTabela.FieldByName('CTP_VALDUP').AsFloat +
                      qryTabela.FieldByName('CTP_JURSUJ').AsFloat -
                      qryTabela.FieldByName('CTP_DESSUJ').AsFloat +
                      qryTabela.FieldByName('CTP_VENDOR').AsFloat);
    End;

    AValorTotalInicial   := AValorTotal;
    ADataCadastroInicial := qryTabela.FieldByName('CTP_DTACAD').AsDateTime;
    AEmpresaInicial      := dbeCodEmp.Text;

    fltValDupAnt := qryTabela.FieldByName('CTP_VALDUP').AsFloat;
    fltValOriAnt := qryTabela.FieldByName('CTP_VALORI').AsFloat;

    fVerificaCampos;

    If Not fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, True, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString), ['&Ok']);

      qryTabela.SQL.Clear;
      qryTabela.SQL.Add('SELECT * FROM ' + strNomeTabela + ' WHERE FALSE');
      qryTabela.Open;

      edtNomEmp.Clear;
      edtNomFor.Clear;

      btnAlterar.Enabled := False;
      Exit;
    End
    ELSE
    begin
      blnDupTravada       := True;
      strAutoincremLckAtc := qryTabela.FieldByName('AUTOINCREM').AsString;
    end;
  End;
end;

function TfrmCadCtaPagarSimplificado.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDtaCad: String;
    strDtaVen: String;
    fltValDup: Double;
    blnValEna: Boolean;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A DUPLICATA                    *}
    {**************************************MV*}
    If (Sender = dbeNumDup) Then
    Begin
      If fEmptyStr(dbeNumDup.Text) Then
      Begin
        dbeParcel.Enabled := False;
      End
      Else if Length(dbeNumDup.Text) < 12 then
      begin
        If (qryTabela.State in [dsInsert]) Then
          dbeNumDup.Text := fStrZero(dbeNumDup.Text, 12);
      end;
    End

    {*****************************************}
    {* VALIDA A PARCELA                      *}
    {**************************************MV*}
    Else If (Sender = dbeParcel) Then
    Begin

      If fEmptyStr(dbeParcel.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Parcela deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not CharInSet(dbeParcel.Text[1], ['A'..'Z']) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Parcela deve estar entre A e Z!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA EMPRESA            *}
    {**************************************MV*}
    Else If (Sender = dbeCodEmp) Then
    Begin
      If Pos(dbeCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}
    Else If (Sender = dbeCodFor) Then
    Begin

      If fEmptyStr(dbeCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaFornecedor;
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          strDtaCad := dbeDtaCad.Text;
          strDtaVen := dbeDtaVen.Text;

          If Not (qryTabela.State In [dsInsert,dsEdit]) Then
            Exit;

          {*****************************************************}
          {* SÓ PODE ALTERAR O VALDUP SE TEM DIREITO DE ACESSO *}
          {**************************************************JU*}
          blnValEna := True;
          If Not fVerificaAcessoSistema('CTPALTVLR') Then
            blnValEna := dbeValDup.Enabled;

          fltValDup := 0.0;
          If (Not fEmptyStr(dbeValDup.Text)) Then
            fltValDup := fStrToFloat(dbeValDup.Text);

          qryTabela.FieldByName('CTP_SEQBAI').AsInteger := 0;

          {**************************************************}
          {* ALTEREI PQ NA ALTERAÇÃO QUANDO ENTRAVA POR     *}
          {* INCLUSAO, ELE JOGAVA DATA DO DIA E NÃO A       *}
          {* DE VENCIMENTO COM QUAL A DUPLICATA FOI GERADA. *}
          {***********************************************AC*}
          If (qryTabela.State = dsInsert) Then
          Begin
            If Not fEmptyStr(fTiraCaracEspeciais(strDtaCad)) Then
              dbeDtaCad.Text := strDtaCad;

            If Not fEmptyStr(fTiraCaracEspeciais(strDtaVen)) Then
              dbeDtaVen.Text := strDtaVen;
          End
          Else If (qryTabela.State = dsEdit) Then
          Begin
            dbeDtaCad.Text := DateToStr(qryTabela.FieldByName('CTP_DTACAD').AsDateTime);
            dbeDtaVen.Text := DateToStr(qryTabela.FieldByName('CTP_DTAVEN').AsDateTime);
          End;

          dbeValDup.Text := FloatToStrF(fltValDup, ffFixed, 12, 2);

          {*****************************************************}
          {* SÓ PODE ALTERAR O VALDUP SE TEM DIREITO DE ACESSO *}
          {**************************************************JU*}
          If Not fVerificaAcessoSistema('CTPALTVLR') Then
          Begin
            dbeValDup.Enabled := False;

            If fEmptyStr(dbeValDup.Text) Then
              dbeValDup.Field.Value := 0.00;

          End
          Else
          Begin
            dbeValDup.Enabled := blnValEna;
          End;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA A DATA DO CADASTRO             *}
    {**************************************MV*}
    Else If (Sender = dbeDtaCad) And dbeDtaCad.Enabled Then
    Begin
      If not fValidaDataStr(dbeDtaCad.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro não é válida!', ['&O k']);
        Result := False;
      end

      Else If fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(dbeDtaCad.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data de Cadastro informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End;

      //FECHAMENTO FINANCEIRO
      //VERIFICA SE É INSERÇÃO OU UMA ALTERAÇÃO DE DATA DE CADASTRO
      if (qryTabela.State = dsInsert) then
        if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
          Result := False;

    End

    {*****************************************}
    {* VALIDA A DATA DO VENCIMENTO           *}
    {**************************************MV*}
    Else If (Sender = dbeDtaVen) And dbeDtaVen.Enabled Then
    Begin
      If not fValidaDataStr(dbeDtaVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento não é válida!', ['&O k']);
        Result := False;
      end

      Else If fEmptyStr(fTiraCaracEspeciais(dbeDtaVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If (StrToDateDef(dbeDtaVen.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data do Vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End

      Else If fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser preenchida!', ['&O k']);
        Sender := dbeDtaCad;
        Result := False;
      End

      Else If (StrToDate(dbeDtaVen.Text) < StrToDate(dbeDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser maior ou igual a Data de Cadastro!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O VALOR DA DUPLICATA           *}
    {**************************************MV*}
    Else If (Sender = dbeValDup) Then
    Begin
      //FECHAMENTO FINANCEIRO
      //SE O VALOR TOTAL FOR ALTERADO VERIFICA FECHAMENTO
      if (qryTabela.State = dsEdit) And
         (AValorTotalInicial <> AValorTotal) Then
      begin
        if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
          Result := False;
      end;

      If fVerificaAcessoSistema('CTPALTVLR') Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(dbeValDup.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do Documento deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If fStrToFloat(dbeValDup.Text) = 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do Documento deve ser diferente de Zero!', ['&O k']);
          Result := False;
        End
        Else If (FloatToStrF(fltValDupAnt, ffNumber, 12, 2) <> dbeValDup.Text) Then
        Begin
          fltValDup := fStrToFloat(dbeValDup.Text);
          If fltValDup > MAX_VALMON Then
          Begin
            fltValDupAnt   := MAX_VALMON;
            dbeValDup.Text := FloatToStr(fltValDupAnt);
          End;

          fltValOriAnt := fltValOriAnt + (fStrToFloat(dbeValDup.Text) - fltValDupAnt);
          fltValDupAnt := fStrToFloat(dbeValDup.Text);
          qryTabela.FieldByName('CTP_VALORI').AsFloat := fltValOriAnt;
        End;
      End
      Else
      Begin

        fltValDup := 0.00;

        If fEmptyStr(dbeValDup.Text) Then
          dbeValDup.Field.Value := 0.00;

        If fltValDup > MAX_VALMON Then
        Begin
          fltValDupAnt   := MAX_VALMON;
          dbeValDup.Text := FloatToStr(fltValDupAnt);
        End;

        fltValOriAnt := fltValOriAnt + (fStrToFloat(dbeValDup.Text) - fltValDupAnt);
        fltValDupAnt := fStrToFloat(dbeValDup.Text);
        qryTabela.FieldByName('CTP_VALORI').AsFloat := fltValOriAnt;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCtaPagarSimplificado.pAfterOpen(DataSet: TDataSet);
begin
  AdicionaDisplayFormatFloatField(Dataset, 'CTP_VALORI', '#,##0.00');
  AdicionaDisplayFormatFloatField(Dataset, 'CTP_VALDUP', '#,##0.00');
  AdicionaDisplayFormatFloatField(Dataset, 'CTP_VALPAG', '#,##0.00');
  AdicionaDisplayFormatFloatField(Dataset, 'CTP_VALJUR', '#,##0.00');
  AdicionaDisplayFormatFloatField(Dataset, 'CTP_VALDES', '#,##0.00');
  AdicionaDisplayFormatFloatField(Dataset, 'CTP_DESSUJ', '#,##0.00');
  AdicionaDisplayFormatFloatField(Dataset, 'CTP_JURSUJ', '#,##0.00');
  AdicionaDisplayFormatFloatField(Dataset, 'CTP_VENDOR', '#,##0.00');

  If DataSet.FindField('CTP_DTAPAG') <> nil Then
    TDateField(DataSet.FieldByName('CTP_DTAPAG')).EditMask := '99/99/9999';

  If DataSet.FindField('CTP_CTABAI') <> nil Then
    TStringField(DataSet.FieldByName('CTP_CTABAI')).EditMask := '99.99.999;0;_';

  If DataSet.FindField('CTP_CODCTA') <> nil Then
    TStringField(DataSet.FieldByName('CTP_CODCTA')).EditMask := '99.99.999;0;_';

  If DataSet.FindField('CTP_DTACAD') <> nil Then
    TDateField(DataSet.FieldByName('CTP_DTACAD')).EditMask := '99/99/9999';

  If DataSet.FindField('CTP_DTAVEN') <> nil Then
    TDateField(DataSet.FieldByName('CTP_DTAVEN')).EditMask := '99/99/9999';
end;

procedure TfrmCadCtaPagarSimplificado.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, dbeCodEmp.Text);
  edtNomEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmCadCtaPagarSimplificado.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, dbeCodFor.Text);
  edtNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmCadCtaPagarSimplificado.pDestravarRegistros;
begin
  inherited;
  If Not qryTabela.IsEmpty Then
  Begin
    qryTabela.First;

    While Not qryTabela.Eof Do
    Begin
      fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, False);

      qryTabela.Next;
    End;
  End;
  blnDupTravada := False;
  strAutoincremLckAtc := '';
end;

procedure TfrmCadCtaPagarSimplificado.pGravaLogCtp(strNumDup, strParcel: String;
  intSeqBai: Integer; strCodEmp, strCodFor, strSerie_: String;
  blnInserindo: Boolean);
Var
  strDescriLogCtp : String;
  objPag: TCadPag;
  objRep: TCadPagRepository;
  strGetCodFor: String;
begin
  Try
    objRep := TCadPagRepository.Create;

    strDescriLogCtp := ifThen(blnInserindo,'INCLUSAO', 'ALTERACAO');
    objPag          := objRep.fRetDuplicata(strNumDup, strParcel, intSeqBai, strCodEmp, strCodFor, strSerie_);

    If Assigned(objPag) Then
    begin
      strGetCodFor := objPag.objCodFor.FOR_CODFOR;
      untLogCtp.pGravaLogCtp(objPag, strDescriLogCtp, Self.Name);
    end;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  If Assigned(objRep) Then
    FreeandNil(objRep);
end;

procedure TfrmCadCtaPagarSimplificado.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CTP_NUMDUP');
  stlCamInd.Add('FOR_NOMFOR+CTP_DTAVEN');
  stlCamInd.Add('FOR_NOMFAN');
  stlCamInd.Add('CTP_DTAVEN');
  stlCamInd.Add('CTP_DTACAD');
  stlCamInd.Add('CTP_VALORI');
  stlCamInd.Add('CTP_CODVEL');

  stlDesInd.Add('Duplicata');
  stlDesInd.Add('Fornecedor/Vencimento');
  stlDesInd.Add('Nome Fantasia');
  stlDesInd.Add('Vencimento');
  stlDesInd.Add('Data de Cadastro');
  stlDesInd.Add('Valor Original');
  stlDesInd.Add('Documento Antigo');
end;

end.
