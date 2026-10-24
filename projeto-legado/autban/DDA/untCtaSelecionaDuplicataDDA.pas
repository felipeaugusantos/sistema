unit untCtaSelecionaDuplicataDDA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, System.StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, Vcl.Mask, MaskEditFocus,
  EditFocus, Uni, UniDataSetProvider, UniClientDataSet, untFuncoesSimples, untFuncoesConsulta, untPesqAux, untTypesSistema,
  cxGroupBox;

type
  TfrmCtaSelecionaDuplicataDDA = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblCodEmp: TLabel;
    Label24: TLabel;
    Label22: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label11: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesCta: TEditFocus;
    mskCodCta: TMaskEditFocus;
    edtVlrIni: TCurrencyEditFocus;
    edtVlrFin: TCurrencyEditFocus;
    btnConsultar: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    pnlAux1: TPanel;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasView: TcxGridDBTableView;
    dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEMP: TcxGridDBColumn;
    dbgDuplicatasFOR_NOMFOR: TcxGridDBColumn;
    dbgDuplicatasCTP_CODPOR: TcxGridDBColumn;
    dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasCTP_VALDUP: TcxGridDBColumn;
    dbgDuplicatasLevel1: TcxGridLevel;
    Label3: TLabel;
    edtNumDup: TEditFocus;
    grpDuplicataOriginal: TcxGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblEmpresa: TLabel;
    lblDuplicata: TLabel;
    lblFornecedor: TLabel;
    lblVencimento: TLabel;
    lblValor: TLabel;
    btnAlteraDuplicata: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure mskCodCtaExit(Sender: TObject);
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultarClick(Sender: TObject);
    procedure dbgDuplicatasViewDblClick(Sender: TObject);
    procedure btnAlteraDuplicataClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgDuplicatasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    cdsCtaPag: TUniClientDataSet;
    qryConFor: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCta: TUniQuery;
    qryConPor: TUniQuery;
    qryCadPag: TUniQuery;

    dtsCtaPag: TDataSource;
    strAceCtp: String;

    arrEmp: TConsultasArray;
    arrFornec: TConsultasArray;
    arrPortador: TConsultasArray;
    arrCentCusto: TConsultasArray;

    strEmp: String;
    strFornec: String;
    strPortador: String;
    strCentCusto: String;
    strAutInc: String;
    strDDADup: String;
    dtaDataVencimento :TDateTime;
    fltValor: Double;
    blnNaoSeleciona: Boolean;
    blnMensagemAlerta: Boolean;

    LCodFor: String;
    LStrOcsDDA : String;
    LFltOcsDDA : Double;

    procedure pAtualizaTemporaria;
    procedure pCarregaFornecedor;
    procedure pCarregaEmpresa;
    function  fGetEmpAceCtp: String;
    procedure pCarregaCentroCusto;
    procedure pCarregaPortador;

    procedure pqryCadPagCTP_DTACADSetText(Sender: TField; const Text: String);
    function fBetween(fltValor: Double): Boolean;

    function RetornaSQLDuplicatas: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }

    class function fSelecionaDuplicataCTP(ADDADup,
      ANumDup, AParcel, ACodEmp, ACodCta, ACodPor, ACodFor: String;
      ADataVencimento: TDateTime; AValor: Double; var AAutCTP: String; ANaoSeleciona: Boolean = False): Boolean;

  end;

var
  frmCtaSelecionaDuplicataDDA: TfrmCtaSelecionaDuplicataDDA;

implementation

{$R *.dfm}

uses untConsultas, untGravando, untCadCtaPagarSimplificado;

{ TfrmCtaSelecionaDuplicataDDA }

procedure TfrmCtaSelecionaDuplicataDDA.btnAlteraDuplicataClick(Sender: TObject);
begin
  inherited;

  if blnNaoSeleciona then
      Exit;

  if cdsCtaPag.IsEmpty then
    Exit;

  If fVerificaAcessoSistema('mnuCtaPagar') And fVerificaAcessoSistema('frmCadCtaPagar') Then
  begin
    Try
      pCriarFormularios(TfrmCadCtaPagarSimplificado, frmCadCtaPagarSimplificado);

      frmCadCtaPagarSimplificado.strAutoIncrem :=  cdsCtaPag.FieldByName('AUTOINCREM').AsString;

      frmCadCtaPagarSimplificado.ShowModal;

      FreeAndNil(frmCadCtaPagarSimplificado);

      strDDADup := cdsCtaPag.FieldByName('AUTOINCREM').AsString;

      btnConsultar.Click;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmOpcoesLancExtrato.pChamarManutencaoCtp]');
    End;
  end
  Else
    pMensagemOk('Operador sem direito de acesso!');
end;

procedure TfrmCtaSelecionaDuplicataDDA.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if not fVerificaCampos then
    Exit;

  TfrmGravando.fExecutarModal(pAtualizaTemporaria, 'Aguarde... Carregando Títulos.', '');

  If not cdsCtaPag.isEmpty Then
    pSetFocus(dbgDuplicatas)
  else
    pSetFocus(edtCodEmp);

end;

procedure TfrmCtaSelecionaDuplicataDDA.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  begin
    btnSair.Click;
  end;

  if (Key = VK_F4) then
  begin
    if not cdsCtaPag.isEmpty then
      btnAlteraDuplicata.Click;
  end;
end;

procedure TfrmCtaSelecionaDuplicataDDA.FormShow(Sender: TObject);
begin
  inherited;
  if blnNaoSeleciona then
    btnAlteraDuplicata.Visible := False;

  LStrOcsDDA := fCfgSis('OSCDDA');
  LFltOcsDDA := fCfgSis('OSCDDA',varDouble);
end;

procedure TfrmCtaSelecionaDuplicataDDA.dbgDuplicatasViewDblClick(
  Sender: TObject);
begin
  inherited;
  if cdsCtaPag.IsEmpty then
    Exit;

  if blnNaoSeleciona then
    Exit;

  if ((dtaDataVencimento <> 0 ) and (cdsCtaPag.FieldByName('CTP_DTAVEN').AsDateTime <> dtaDataVencimento)) then
  begin
    fMensagem('ATENÇÃO!', 'O campo Data de Vencimento, difere da duplicata importada pelo DDA. ' +  #13 + #13 +
                          'Por ser uma informação que consta na linha digítavel/código de barras ' +
                          'ambas devem ser iguais para evitar rejeição do registro' +  #13  + ' no arquivo remessa.', ['&Ok']);
    Exit;
  end;

  if ((fltValor <> 0 ) and (fFormataFloat(cdsCtaPag.FieldByName('CTP_VALDUP').ASCurrency, 2) <> fFormataFloat(fltValor, 2))) then
  begin
    fMensagem('ATENÇÃO!', 'O campo Valor da Duplicata, difere da duplicata importada pelo DDA. ' + #13 + #13 +
                          'Por ser uma informação que consta na linha digítavel/código de barras ' +
                          'ambos devem ser iguais para evitar rejeição do registro' +  #13  + ' no arquivo remessa.', ['&Ok']);
    Exit;
  end;

  strAutInc :=  cdsCtaPag.FieldByName('AUTOINCREM').AsString;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmCtaSelecionaDuplicataDDA.dbgDuplicatasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then
  begin
    if cdsCtaPag.IsEmpty then
      Exit;

    if blnNaoSeleciona then
      Exit;

    if ((dtaDataVencimento <> 0 ) and (cdsCtaPag.FieldByName('CTP_DTAVEN').AsDateTime <> dtaDataVencimento)) then
    begin
      fMensagem('ATENÇÃO!', 'O campo Data de Vencimento, difere da duplicata importada pelo DDA. ' +  #13 + #13 +
                            'Por ser uma informação que consta na linha digítavel/código de barras ' +
                            'ambas devem ser iguais para evitar rejeição do registro' +  #13  + ' no arquivo remessa.', ['&Ok']);
      Exit;
    end;

    if ((fltValor <> 0 ) and (fFormataFloat(cdsCtaPag.FieldByName('CTP_VALDUP').ASCurrency, 2) <> fFormataFloat(fltValor, 2))) then
    begin
      fMensagem('ATENÇÃO!', 'O campo Valor da Duplicata, difere da duplicata importada pelo DDA. ' + #13 + #13 +
                            'Por ser uma informação que consta na linha digítavel/código de barras ' +
                            'ambos devem ser iguais para evitar rejeição do registro' +  #13  + ' no arquivo remessa.', ['&Ok']);
      Exit;
    end;

    strAutInc :=  cdsCtaPag.FieldByName('AUTOINCREM').AsString;
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmCtaSelecionaDuplicataDDA.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmCtaSelecionaDuplicataDDA.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    LWhere : String;
    LC_G_C : String;
begin
  inherited;
  LC_G_C := fCampoTabela('FOR_C_G_C_', 'CADFOR', ['FOR_CODFOR'], [LCodFor]);
  LWhere := ' SUBSTRING(FOR_C_G_C_, 1 ,8) =  SUBSTRING('+ QuotedStr(LC_G_C) + ', 1 ,8)';
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False, Nil, LWhere) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtaSelecionaDuplicataDDA.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPor, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmCtaSelecionaDuplicataDDA.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrPortador, False) Then
    If fValidaCampos(edtCodPor) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmCtaSelecionaDuplicataDDA.fBetween(fltValor: Double): Boolean;
begin
  Result := True;

  If fEmptyStr(LStrOcsDDA) Then
    Exit;

  Result := (fFormataFloat(fltValor,2) <= fFormataFloat(LFltOcsDDA,2));
end;

function TfrmCtaSelecionaDuplicataDDA.fGetEmpAceCtp: String;
begin
  Result:= fCampoTabela('OPE_EMPCTP', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

  Result := Copy(Result, 0, (Length(Result) -1));

  If Not fEmptyStr(Result) Then
    Result := AnsiReplaceStr(Result,'_', ',');
end;

procedure TfrmCtaSelecionaDuplicataDDA.FormCreate(Sender: TObject);
begin
  inherited;
  blnMensagemAlerta := True;
  strAutInc := '';
  strDDADup := '';
  blnNaoSeleciona := False;
  dtaDataVencimento := 0;
  fltValor := 0;
  qryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
  qryCadPag.FieldByName('CTP_DTACAD').OnSetText := pqryCadPagCTP_DTACADSetText;
  qryCadPag.Open;

  cdsCtaPag := TUniClientDataSet.Create(Self);
  dtsCtaPag := fCriaDataSource(cdsCtaPag);
  dbgDuplicatasView.DataController.DataSource := dtsCtaPag;


  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);

  strAceCtp:= fGetEmpAceCtp;
end;

class function TfrmCtaSelecionaDuplicataDDA.fSelecionaDuplicataCTP(ADDADup,
  ANumDup, AParcel, ACodEmp, ACodCta, ACodPor, ACodFor: String;
  ADataVencimento: TDateTime; AValor: Double; var AAutCTP: String; ANaoSeleciona: Boolean = False): Boolean;
  Var
    LStrOcsDDA : String;
    LFltOcsDDA : Double;
begin
  Try
    pCriarFormularios(TfrmCtaSelecionaDuplicataDDA, frmCtaSelecionaDuplicataDDA);

    frmCtaSelecionaDuplicataDDA.lblEmpresa.Caption    :=  ACodEmp + ' - ' + fRetNomeEmpresa(ACodEmp);
    frmCtaSelecionaDuplicataDDA.lblDuplicata.Caption  :=  ANumDup + ' - ' + AParcel;
    frmCtaSelecionaDuplicataDDA.lblFornecedor.Caption :=  ACodFor + ' - ' + fRetNomFornecedor(ACodFor);
    frmCtaSelecionaDuplicataDDA.lblValor.Caption      :=  FormatFloat('R$ ###,###,##0.00', AValor);
    frmCtaSelecionaDuplicataDDA.lblVencimento.Caption :=  FormatDateTime('dd/mm/yyyy', ADataVencimento);
    frmCtaSelecionaDuplicataDDA.blnNaoSeleciona := ANaoSeleciona;
    frmCtaSelecionaDuplicataDDA.dtaDataVencimento := ADataVencimento;
    frmCtaSelecionaDuplicataDDA.fltValor := AValor;
    frmCtaSelecionaDuplicataDDA.LCodFor := ACodFor;

    LStrOcsDDA := fCfgSis('OSCDDA');
    LFltOcsDDA := fCfgSis('OSCDDA',varDouble);

    if ADDADup = '' then
    begin
      frmCtaSelecionaDuplicataDDA.edtCodEmp.Text := ACodEmp;
      frmCtaSelecionaDuplicataDDA.edtCodFor.Text := ACodFor;
      //frmCtaSelecionaDuplicataDDA.mskCodCta.Text := ACodCta;
      //frmCtaSelecionaDuplicataDDA.edtCodPor.Text := ACodPor;
      //frmCtaSelecionaDuplicataDDA.edtNumDup.Text := ANumDup;
      frmCtaSelecionaDuplicataDDA.edtVlrIni.Value := IIF(fEmptyStr(LStrOcsDDA),AValor - 1, AValor - LFltOcsDDA);
      frmCtaSelecionaDuplicataDDA.edtVlrFin.Value := IIF(fEmptyStr(LStrOcsDDA),AValor + 1, AValor + LFltOcsDDA);
      frmCtaSelecionaDuplicataDDA.mskDtaIni.Date :=  IncMonth(ADataVencimento, -1);
      frmCtaSelecionaDuplicataDDA.mskDtaFin.Date :=  IncMonth(ADataVencimento, 1);
      frmCtaSelecionaDuplicataDDA.blnMensagemAlerta := False;
      frmCtaSelecionaDuplicataDDA.fVerificaCampos;
      frmCtaSelecionaDuplicataDDA.btnConsultar.Click;
      frmCtaSelecionaDuplicataDDA.blnMensagemAlerta := True;

      pSetFocus(frmCtaSelecionaDuplicataDDA.btnConsultar);
    end
    Else
    begin
      frmCtaSelecionaDuplicataDDA.strDDADup :=  ADDADup;
      frmCtaSelecionaDuplicataDDA.btnConsultar.Click;
    end;

    frmCtaSelecionaDuplicataDDA.showModal;
    Result := (frmCtaSelecionaDuplicataDDA.ModalResult = mrOk);

    If (Result) Then
      AAutCTP := frmCtaSelecionaDuplicataDDA.strAutInc;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCtaSelecionaDuplicataDDA.fSelecionaDuplicataCTP]');
    End;
  End;

  pFreeAndNil(frmCtaSelecionaDuplicataDDA);
end;

function TfrmCtaSelecionaDuplicataDDA.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}

    If (Sender = edtCodFor) Then
    Begin
      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin

        If edtCodFor.Text <> '00000000' Then
           pCarregaFornecedor;

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          if blnMensagemAlerta then
            fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtNomFor.Clear;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
        edtNomEmp.Clear
      Else
      Begin

        If edtCodEmp.Text <> '000' Then
           pCarregaEmpresa;

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          if blnMensagemAlerta then
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          if blnMensagemAlerta then
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(LeftStr(edtCodEmp.Text,3), strAceCtp) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          if blnMensagemAlerta then
            fMensagem('ATENÇÃO!', 'Usuário sem permissão no Baixa contas a pagar desta empresa!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************MV*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        mskDtaFin.Enabled := False
      Else
        mskDtaFin.Enabled := True;

    End

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************MV*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          if blnMensagemAlerta then
            fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          if blnMensagemAlerta then
            fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtVlrIni) Then
    Begin

      If Not fBetween(fltValor - fStrToFloat(edtVlrIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Permitido apenas oscilicações de até ' + FormatFloat( '#,##0.00', LFltOcsDDA ) + ' sobre o valor total!' , ['&O k']);
        Result := False;
      End

    End

    Else If (Sender = edtVlrFin) Then
    Begin

      If (edtVlrFin.Value = 0) And (edtVlrIni.Value <> 0) Then
      Begin
        if blnMensagemAlerta then
          fMensagem('ATENÇÃO!', 'O Valor Final deve ser informado!', ['&O k']);
        Result := False;
      End
      Else If (edtVlrFin.Value < edtVlrIni.Value) Then
      Begin
        if blnMensagemAlerta then
          fMensagem('ATENÇÃO!', 'O Valor Final deve ser maior ou igual ao Valor Inicial!', ['&O k']);
        Result := False;
      End
      Else If Not fBetween(fStrToFloat(edtVlrFin.Text) - fltValor) Then
      Begin
        fMensagem('ATENÇÃO!', 'Permitido apenas oscilicações de até ' + FormatFloat( '#,##0.00', LFltOcsDDA ) + ' sobre o valor total!' , ['&O k']);
        Result := False;
      End
      Else If (edtCodEmp.Text <> '000') And (edtNomEmp.Text <> '+1') And (Not fEmptyStr(edtCodEmp.Text))
        And (not (Pos(LeftStr(edtCodEmp.Text,3), strAceCtp) > 0)) Then
      Begin
        if blnMensagemAlerta then
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
        Result := False;
      End;
    End
    {***************************************}
    {* VALIDA CENTRO DE CUSTO              *}
    {************************************JU*}
    Else If (Sender = mskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text)) Then
      Begin

        If mskCodCta.Text <> '0' Then
           pCarregaCentroCusto;

        if fEmptyStr(EdtDesCta.Text) Then
        Begin
           if blnMensagemAlerta then
             fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
           Result := False;
        End;
      End
      Else
      Begin
        edtDesCta.Clear;
      End;
    End
    {**************************************}
    {* VALIDA O CÓDIGO DO PORTADOR        *}
    {***********************************JU*}
    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin

        If edtCodPor.Text <> '00000' Then
           pCarregaPortador;

       if fEmptyStr(EdtDesPor.Text) Then
        Begin
          if blnMensagemAlerta then
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin

          If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              if blnMensagemAlerta then
                fMensagem('ATENÇÃO!', 'Você não permissão para utilizar este portador!', ['&O k']);
              Result := False;
            End;
          End;

        End;

      End
      Else
        edtDesPor.Clear;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCtaSelecionaDuplicataDDA.mskCodCtaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskCodCta, edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta');
end;

procedure TfrmCtaSelecionaDuplicataDDA.mskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskCodCta, edtDesCta, Nil, Key, arrCentCusto) Then
  Begin
    If fValidaCampos(mskCodCta, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtaSelecionaDuplicataDDA.pAtualizaTemporaria;
  Var
    strSQL: String;
    qryCtaPag: TUniQuery;
    dspCtaPag: TUniDataSetProvider;
begin

  If (fCfgSis('DACPOR', varBoolean)) And
     Not (fEmptyStr(edtCodPor.Text)) Then
  Begin
    If Not fValidaCampos(edtCodPor) Then
    Begin
      blnMudarFoco := False;
      Exit;
    End;
  End;

  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
  qryCtaPag := fCriaQuery(Self);
  dspCtaPag := TUniDataSetProvider.Create(Self);
  dspCtaPag.DataSet := qryCtaPag;
  cdsCtaPag.SetProvider(dspCtaPag);

  Try
    strSQL := RetornaSQLDuplicatas;

    qryCtaPag.Close;
    qryCtaPag.SQL.Clear;
    qryCtaPag.SQL.Add(strSQL);

    if strDDADup = '' then
    begin
      pSetaParam(edtCodFor.Text, arrFornec, strFornec,'CODFOR',qryCtaPag);
      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryCtaPag);
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR' ,qryCtaPag);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        qryCtaPag.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        qryCtaPag.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      End;

      If edtVlrFin.Value <> 0 Then
      Begin
        qryCtaPag.ParamByName('VALINI').AsFloat := edtVlrIni.Value;
        qryCtaPag.ParamByName('VALFIN').AsFloat := edtVlrFin.Value;
      End;

      pSetaParam(mskCodCta.Text, arrCentCusto ,strCentCusto ,'CODCTA',qryCtaPag);
    end
    else
    begin
      qryCtaPag.ParamByName('AUTOINC').AsString := strDDADup;

      strDDADup := '';
    end;

    qryCtaPag.Open;

    Application.ProcessMessages;

    If Not qryCtaPag.IsEmpty Then
    Begin
      pSetaClient(qryCtaPag);
      cdsCtaPag.Open;
      (cdsCtaPag.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_DESSUJ') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_JURSUJ') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_VENDOR') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('TOTDUP')     As TFloatField).DisplayFormat := '#,##0.00';
      cdsCtaPag.IndexFieldNames := 'CTP_DTAVEN;CTP_CODFOR;CTP_NUMDUP;CTP_CODEMP';
      cdsCtaPag.First;

      Application.ProcessMessages;
    End
    Else
    Begin
      if blnMensagemAlerta then
        fMensagem('ATENÇÃO!', 'Não há duplicatas para o filtro informado!', ['&O k']);

      blnMudarFoco := False;
      pSetFocus(edtCodFor);
    End;

    qryCtaPag.Close;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCtaPagar.pAtualizaTemporaria]');
    End;
  End;

  Application.ProcessMessages;
  cdsCtaPag.SetProvider(nil);
  FreeAndNil(dspCtaPag);
  FreeAndNil(qryCtaPag);
end;

procedure TfrmCtaSelecionaDuplicataDDA.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, mskCodCta.Text);
  edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmCtaSelecionaDuplicataDDA.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmCtaSelecionaDuplicataDDA.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  edtNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmCtaSelecionaDuplicataDDA.pCarregaPortador;
begin
  pPesquisaCadPor(qryConPor, qryConPor, edtCodPor.Text);
  edtDesPor.Text := qryConPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmCtaSelecionaDuplicataDDA.pqryCadPagCTP_DTACADSetText(
  Sender: TField; const Text: String);
begin
  If (fEmptyStr(fTiraCaracEspeciais(Text))) Then
    TDateField(Sender).AsVariant := Null
  Else
    TDateField(Sender).AsVariant := Text;
end;

function TfrmCtaSelecionaDuplicataDDA.RetornaSQLDuplicatas: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  P.CTP_NUMDUP AS NRODUP, ';
  Result := Result + '  P.CTP_PARCEL AS PARDUP, ';
  Result := Result + '  CONCAT(P.CTP_NUMDUP, P.CTP_PARCEL) AS CTP_NUMDUP, ';
  Result := Result + '  P.CTP_CODFOR, ';
  Result := Result + '  F.FOR_NOMFOR, ';
  Result := Result + '  F.FOR_FONE01, ';
  Result := Result + '  F.FOR_F_A_X_, ';
  Result := Result + '  CONCAT(P.CTP_CODFOR ,"-", F.FOR_NOMFOR) AS CTP_NOMFOR, ';
  Result := Result + '  F.FOR_C_G_C_, ';
  Result := Result + '  P.CTP_CODEMP, ';
  Result := Result + '  P.CTP_SERIE_, ';
  Result := Result + '  E.EMP_NOMEMP, ';
  Result := Result + '  P.CTP_CODCTA, ';
  Result := Result + '  C.CTA_DESCTA, ';
  Result := Result + '  P.CTP_HIST01, ';
  Result := Result + '  P.CTP_HIST02, ';
  Result := Result + '  P.CTP_PREVIS, ';
  Result := Result + '  IF(P.CTP_VEIOBO = "S", "SIM", "NÃO") AS CTP_VEIOBO, ';
  Result := Result + '  P.CTP_DTACAD, ';
  Result := Result + '  P.CTP_DTAVEN, ';
  Result := Result + '  P.CTP_VALORI, ';
  Result := Result + '  P.CTP_VALDUP, ';
  Result := Result + '  P.CTP_VALPAG, ';
  Result := Result + '  P.CTP_DTAPAG, ';
  Result := Result + '  P.CTP_VALJUR, ';
  Result := Result + '  P.CTP_VALDES, ';
  Result := Result + '  P.CTP_CODEVE, ';
  Result := Result + '  P.CTP_TIPDOC, ';
  Result := Result + '  P.CTP_CODVEL, ';
  Result := Result + '  P.CTP_CODPOR, ';
  Result := Result + '  CONCAT(P.CTP_CODPOR ,"-", R.POR_NOMPOR) AS CTP_NOMPOR, ';
  Result := Result + '  P.CTP_PORBAI, ';
  Result := Result + '  B.POR_NOMPOR, ';
  Result := Result + '  IF(P.CTP_USACHQ = "S", "SIM", "NÃO") AS CTP_USACHQ, ';
  Result := Result + '  V.EVE_DESEVE, ';
  Result := Result + '  IFNULL(P.CTP_DESSUJ, 0) AS CTP_DESSUJ, ';
  Result := Result + '  IFNULL(P.CTP_JURSUJ, 0) AS CTP_JURSUJ, ';
  Result := Result + '  IFNULL(P.CTP_VENDOR, 0) AS CTP_VENDOR, ';
  Result := Result + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0)) -IFNULL(P.CTP_DESSUJ,0) AS TOTDUP, ';
  Result := Result + '  " " AS CTP_MARDES, ';
  Result := Result + '  " " AS CTP_TIPBAI, ';
  Result := Result + '  " " AS CTP_TIPDES, ';
  Result := Result + '  P.AUTOINCREM, ';
  Result := Result + '  "CADPAG" AS TABELA, ';
  Result := Result + '  CTP_COMPET,         ';
  Result := Result + '  P.CTP_DINHEI, ';
  Result := Result + '  P.CTP_CHQAVI, ';
  Result := Result + '  P.CTP_ORDPAG, ';
  Result := Result + '  P.CTP_REPCHQ, ';
  Result := Result + '  P.CTP_SEQBAI, ';
  Result := Result + '  P.CTP_DTALIB  ';
  Result := Result + 'FROM ';
  Result := Result + '  CADPAG P ';
  Result := Result + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
  Result := Result + '  JOIN CADEMP E ON P.CTP_CODEMP = E.EMP_CODEMP ';
  Result := Result + '  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ';

  Result := Result + ' LEFT JOIN CADEVE V ON P.CTP_CODEVE = V.EVE_CODEVE ';
  Result := Result + ' LEFT JOIN CADPOR B ON P.CTP_PORBAI = B.POR_CODPOR ';
  Result := Result + ' LEFT JOIN CADPOR R ON P.CTP_CODPOR = R.POR_CODPOR ';
  Result := Result + ' LEFT JOIN RETDDA D ON D.DDA_AUTCTP = P.AUTOINCREM ';
  Result := Result + 'WHERE ';

  if strDDADup = '' then
  begin
    Result := Result + '  D.DDA_AUTCTP IS NULL AND ';

    {**************************************}
    {* DEVIDO À ALTERAÇÃO DA MINAS TINTAS *}
    {* CRIANDO DIREITO DE ACESSO PARA     *}
    {* PODER OU NÃO ALTERAR O VALOR DA    *}
    {* DUPLICATA AGORA VÃO EXISTIR        *}
    {* REGISTROS NO CADPAG COM VALDUP = 0 *}
    {* E QUE NÃO PODEM SER BAIXADOS       *}
    {*06/07/2012************************JU*}
    Result := Result + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_VENDOR,0)) -IFNULL(P.CTP_DESSUJ,0) <> 0 AND ';

    Result := Result + '  P.CTP_DTAPAG IS NULL AND ';
    Result := Result + '  P.CTP_SEQBAI = 0 ';

    Result := Result + fStrLocate(edtCodFor, arrFornec, 'P.CTP_CODFOR', 'CODFOR');

    Result := Result + fStrLocate(edtCodEmp, arrEmp, 'P.CTP_CODEMP', 'CODEMP');

    If (Not fEmptyStr(edtCodPor.Text)) Then
        Result := Result + fStrLocate(edtCodPor, arrPortador, 'P.CTP_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      Result := Result + '  AND (IFNULL(P.CTP_CODPOR, "") = "" ';
      Result := Result + '  OR LOCATE(P.CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Result := Result + '  AND P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtNumDup.Text) Then
      Result := Result + '  AND P.CTP_NUMDUP LIKE "%' + edtNumDup.Text + '%" ';

    If edtVlrFin.Value <> 0 Then
      Result := Result + '  AND P.CTP_VALORI BETWEEN :VALINI AND :VALFIN ';

    Result := Result + fStrLocateLinGru(mskCodCta, arrCentCusto, 'P.CTP_CODCTA', 'CODCTA');
  end
  else
    Result := Result + '  P.AUTOINCREM = :AUTOINC ';
end;

end.
