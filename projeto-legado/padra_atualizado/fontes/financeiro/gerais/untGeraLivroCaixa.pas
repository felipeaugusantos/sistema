unit untGeraLivroCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, DBCtrls, DBEditFocus, untFuncoesSimples,
  Uni, ComCtrls, BitBtnLockedIncrem, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmGeraLivroCaixa = class(TfrmPaiEdit)
    Label5: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    edtCentroCusto: TEditFocus;
    mskCodCta: TMaskEditFocus;
    prgProgresso: TProgressBar;
    btnGravar: TBitBtnLocked;
    lblPortador: TLabel;
    edtNomPorOri: TEditFocus;
    edtCodPorOri: TEditFocus;
    lblCCustoOri: TLabel;
    edtDesCustoOri: TEditFocus;
    mskCodCtaOri: TMaskEditFocus;
    shpMultSel: TShape;
    chkApagar: TCheckBox;
    gpbArquivos: TGroupBox;
    chkCadRec: TCheckBox;
    chkCadPag: TCheckBox;
    chkCadRcxx: TCheckBox;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskCodCtaOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorOriExit(Sender: TObject);
    procedure mskCodCtaOriExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConPor, qryConCta, qryConPorOri,
    qryCadEmp: TUniQuery;

    procedure pCarregaEmpresa;
    procedure pCarregaPortador;
    procedure pCarregaCentroCusto;
    Procedure pGravaCtr;
    Procedure pGravaCtp;
    procedure pGravaCaixa;
    Procedure pApagaMovBan;

//    Function fTemMovBan: Boolean;
    Function fGeraLivro: Boolean;
    Function fConfimaExclusaoRegistros: Boolean;
    function fConfirmaArquivosGeracao: Boolean;

  public
    { Public declarations }
    arrPortador    : TConsultasArray;
    arrCentroCusto : TConsultasArray;

    strPortador    : String;
    strCentroCusto : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmGeraLivroCaixa: TfrmGeraLivroCaixa;

implementation

uses untPai,untPesqAux, DB, untFuncoesConsulta, untCadCta, untMovBan,
     untConsultas, untTBanCtrRepository, untTBanCtpRepository,
     untTBanTrf;

{$R *.dfm}

function TfrmGeraLivroCaixa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a Empresa!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (qryCadEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodPor) Then
    Begin
      If fEmptyStr(edtCodPor.Text) Then
      Begin

        fMensagem('ATENÇÃO!', 'O Portador da Baixa deve ser preenchido!', ['&O k']);
        Result := False;

      End
      Else
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End

        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodPorOri) Then
    Begin
      If Not fEmptyStr(edtCodPorOri.Text) Then
      Begin
        edtNomPorOri.Text := fRetNomPortador(edtCodPorOri.Text);

        If fEmptyStr(edtNomPorOri.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End

        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPorOri.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = mskCodCta) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskCodCta.Text)) Then
      Begin

        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!', ['&O k']);
        Result := False;

      End
      Else
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaLinhaGrupoCadCta(mskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmGeraLivroCaixa.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryCadEmp, qryCadEmp, edtCodEmp.Text);
  With qryCadEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmGeraLivroCaixa.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmGeraLivroCaixa.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, mskCodCta.Text);
  With qryConCta Do
  Begin
    edtCentroCusto.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmGeraLivroCaixa.mskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskCodCta, edtCentroCusto, Nil, Key, arrCentroCusto) Then
  Begin
    If (fValidaCampos(mskCodCtaOri, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    pCarregaCentroCusto;
  End;
end;

procedure TfrmGeraLivroCaixa.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

Procedure TfrmGeraLivroCaixa.pApagaMovBan;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Clear;

    Add('DELETE FROM ');
    Add(' MOVBAN ');
    Add('WHERE');
    Add('  CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN AND');
    Add('  CTB_CODEMP = :CODEMP AND ');
    Add('  CTB_CODPOR = :CODPOR ');

    ParamByName('CODPOR').AsString := edtCodPor.Text;
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    ExecSQL;
  End;

  FreeAndNil(qryGen);

End;

Procedure TfrmGeraLivroCaixa.pGravaCtr;
  Var
    qryGen: TUniQuery;
    lstBanCtr : TBanCtrRepository;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Clear;

    Add('SELECT ');
    Add('  CLI_NOMCLI AS NOMCLI, ');
    Add('  CTR_NUMDUP AS NUMDUP, ');
    Add('  CTR_PARCEL AS PARCEL, ');
    Add('  CTR_CODCLI AS CODCLI, ');
    Add('  CTR_OPEBAI AS OPEBAI, ');
    Add('  CTR_DTAREC AS DTAREC, ');
    Add('  CTR_VALREC AS VALREC, ');
    Add('  CTR_HIST01 AS HISTOR, ');
    Add('  CTR_HIST02 AS HIST02, ');
    Add('  CTR_ESPDOC AS ESPDOC, ');
    Add('  CTR_CODEMP AS CODEMP, ');
    Add('  CTR_SEQBAI AS SEQBAI  ');
    Add('FROM ');
    Add('  CADREC ');
    Add('INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI');
    Add('WHERE');
    Add('  CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN AND');
    Add('  CTR_CODEMP = :CODEMP');

    If (Not fEmptyStr(edtCodPorOri.Text)) Then
      Add(fStrLocate(edtCodPorOri, arrPortador, 'CTR_PORBAI','CODPOR'));

    If (Not fEmptyStr(fTiraCaracEspeciais(mskCodCtaOri.Text))) Then
      Add(fStrLocate(mskCodCtaOri,  arrCentroCusto,  'CTR_CTABAI', 'CODCTA'));

    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    If (Not fEmptyStr(edtCodPorOri.Text)) Then
      pSetaParam(edtCodPorOri.Text, arrPortador, strPortador, 'CODPOR', qryGen);

    If (Not fEmptyStr(fTiraCaracEspeciais(mskCodCtaOri.Text))) Then
      pSetaParam(mskCodCtaOri.Text, arrCentroCusto, strCentroCusto, 'CODCTA', qryGen);

    Open;

    prgProgresso.Position := 0;
    prgProgresso.Max := RecordCount;
    pnlInfo.Caption := 'Gerando movimento para o Contas a Receber';

    lstBanCtr := TBanCtrRepository.Create;

    While Not Eof Do
    Begin
      lstBanCtr.pClear;
      lstBanCtr.fAdd(FieldByName('NUMDUP').AsString,
                     FieldByName('PARCEL').AsString,
                     FieldByName('ESPDOC').AsString,
                     FieldByName('CODEMP').AsString,
                     FieldByName('CODCLI').AsString,
                     FieldByName('HISTOR').AsString,
                     FieldByName('HIST02').AsString,
                     FieldByName('SEQBAI').AsInteger,
                     IIF(FieldByName('VALREC').AsFloat < 0.0, (-1) * FieldByName('VALREC').AsFloat, FieldByName('VALREC').AsFloat));

      If fEmptyStr(fGravaMovBan(fTiraCaracEspeciais(mskCodCta.Text),
                                edtCodPor.Text,
                                FieldByName('OPEBAI').AsString,
                                FieldByName('DTAREC').AsDateTime,
                                fTime(),
                                FieldByName('NUMDUP').AsString,
                                IIF(FieldByName('VALREC').AsFloat < 0.0, 'D', 'C'),
                                edtCodEmp.Text,
                                IIF(FieldByName('VALREC').AsFloat < 0.0, (-1) * FieldByName('VALREC').AsFloat, FieldByName('VALREC').AsFloat),
                                FieldByName('NOMCLI').AsString,
                                FieldByName('HISTOR').AsString,
                                FieldByName('CODCLI').AsString,
                                '',
                                FieldByName('NUMDUP').AsString,
                                0,
                                FieldByName('PARCEL').AsString,
                                edtCodEmp.Text,
                                '',
                                '',
                                '',
                                lstBanCtr.fGetList)) Then
         Break;

      Next;
      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;

    End;

    FreeAndNil(lstBanCtr);

    prgProgresso.Position := 0;
    pnlInfo.Caption := '';

  End;

  FreeAndNil(qryGen);
End;


Procedure TfrmGeraLivroCaixa.pGravaCtp;
  Var
    qryGen: TUniQuery;
    lstBanCtp : TBanCtpRepository;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Clear;

    Add('SELECT ');
    Add('  FOR_NOMFOR AS NOMFOR, ');
    Add('  CTP_NUMDUP AS NUMDUP, ');
    Add('  CTP_PARCEL AS PARCEL, ');
    Add('  CTP_CODFOR AS CODFOR, ');
    Add('  CTP_OPEBAI AS OPEBAI, ');
    Add('  CTP_DTAPAG AS DTAPAG, ');
    Add('  CTP_VALPAG AS VALPAG, ');
    Add('  CTP_HIST01 AS HISTOR, ');
    Add('  CTP_HIST02 AS HIST02, ');
    Add('  CTP_SERIE_ AS SERIE_, ');
    Add('  CTP_CODEMP AS CODEMP, ');
    Add('  CTP_CODCTA AS CODCTA, ');
    Add('  CTP_SEQBAI AS SEQBAI  ');
    Add('FROM ');
    Add(' CADPAG ');
    Add('INNER JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR');
    Add('WHERE');
    Add('  CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN AND');
    Add('  CTP_CODEMP = :CODEMP');

    If (Not fEmptyStr(edtCodPorOri.Text)) Then
      Add(fStrLocate(edtCodPorOri, arrPortador, 'CTP_PORBAI','CODPOR'));

    If (Not fEmptyStr(fTiraCaracEspeciais(mskCodCtaOri.Text))) Then
      Add(fStrLocate(mskCodCtaOri,  arrCentroCusto,  'CTP_CTABAI', 'CODCTA'));

    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    If (Not fEmptyStr(edtCodPorOri.Text)) Then
      pSetaParam(edtCodPorOri.Text, arrPortador, strPortador, 'CODPOR', qryGen);

    If (Not fEmptyStr(fTiraCaracEspeciais(mskCodCtaOri.Text))) Then
      pSetaParam(mskCodCtaOri.Text, arrCentroCusto, strCentroCusto, 'CODCTA', qryGen);

    Open;

    prgProgresso.Position := 0;
    prgProgresso.Max := RecordCount;
    pnlInfo.Caption := 'Gerando movimento para o Contas a Pagar';

    lstBanCtp := TBanCtpRepository.Create;

    While Not Eof Do
    Begin
      lstBanCtp.pClear;
      lstBanCtp.fAdd(FieldByName('NUMDUP').AsString,
                     FieldByName('PARCEL').AsString,
                     FieldByName('SERIE_').AsString,
                     FieldByName('CODEMP').AsString,
                     FieldByName('CODFOR').AsString,
                     FieldByName('HISTOR').AsString,
                     FieldByName('HIST02').AsString,
                     FieldByName('CODCTA').AsString,
                     edtCodEmp.Text,
                     FieldByName('SEQBAI').AsInteger,
                     IIF(FieldByName('VALPAG').AsFloat < 0.0, (-1) * FieldByName('VALPAG').AsFloat, FieldByName('VALPAG').AsFloat),
                     0,
                     0,
                     0,
                     0);

      If fEmptyStr(fGravaMovBan(fTiraCaracEspeciais(mskCodCta.Text),
                                edtCodPor.Text,
                                FieldByName('OPEBAI').AsString,
                                FieldByName('DTAPAG').AsDateTime,
                                fTime(),
                                FieldByName('NUMDUP').AsString,
                                IIF(FieldByName('VALPAG').AsFloat < 0.0, 'C', 'D'),
                                edtCodEmp.Text,
                                IIF(FieldByName('VALPAG').AsFloat < 0.0, (-1) * FieldByName('VALPAG').AsFloat, FieldByName('VALPAG').AsFloat),
                                FieldByName('NOMFOR').AsString,
                                FieldByName('HISTOR').AsString,
                                FieldByName('CODFOR').AsString,
                                '',
                                FieldByName('NUMDUP').AsString,
                                0,
                                FieldByName('PARCEL').AsString,
                                edtCodEmp.Text,
                                '',
                                '',
                                '',
                                lstBanCtp.fGetList)) Then
         Break;

      Next;
      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;

    End;

    prgProgresso.Position := 0;
    pnlInfo.Caption := '';
    FreeAndNil(lstBanCtp);
  End;

  FreeAndNil(qryGen);
End;

Function TfrmGeraLivroCaixa.fGeraLivro: Boolean;
Begin
  Try
    fStartTransaction;

    If (chkApagar.Checked) Then
      pApagaMovBan;

    If (chkCadRec.Checked) Then
      pGravaCtr;

    If (chkCadPag.Checked) Then
      pGravaCtp;

    If (chkCadRcxx.Checked) Then
      pGravaCaixa;

    fCommit;
    Result := True;

    prgProgresso.Position := 0;
    pnlInfo.Caption := '';

  Except
    on E: Exception Do
    Begin
      prgProgresso.Position := 0;
      pnlInfo.Caption := '';

      fRollBack;
      Result := False;
      pMensagensErro(E.Message,'[TfrmGeraLivroCaixa.fGeraLivro]');
    End;
  End;
End;

Function TfrmGeraLivroCaixa.fConfimaExclusaoRegistros: Boolean;
Begin
  If chkApagar.Checked Then
    Result := fMensagem('', 'Tem certeza que deseja apagar as gerações anteriores?', ['&Sim', '&Não'], 2) = 1
  Else
    Result := True;
End;

procedure TfrmGeraLivroCaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrok) Then
  Begin
    If fVerificaCampos And
       (fMensagem('', 'Confirma a Geração do Livro Caixa?', ['&Sim', '&Não']) = 1) And
       fConfirmaArquivosGeracao And
       fConfimaExclusaoRegistros And
       fGeraLivro Then
      fMensagem('', 'Livro Gerado com sucesso!', ['&Ok'])
    Else
      Action := caNone;
  End;

end;

procedure TfrmGeraLivroCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  qryConPor    := fCriaQuery(Self);
  qryConPorOri := fCriaQuery(Self);
  qryConCta    := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadEmp    := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  shpMultSel.Visible := True;
end;

procedure TfrmGeraLivroCaixa.FormShow(Sender: TObject);
begin
  inherited;

  edtCodPor.Text := fCfgSis('PORGER');
  fValidaCampos(edtCodPor);

  edtCodEmp.Text := VS_strCodEmp;
  fValidaCampos(edtCodEmp);

end;

procedure TfrmGeraLivroCaixa.mskCodCtaOriKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskCodCtaOri, edtDesCustoOri, Nil, Key, arrCentroCusto) Then
  Begin
    If (fValidaCampos(mskCodCtaOri, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    pCarregaCentroCusto;
  End;
end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmGeraLivroCaixa.edtCodPorOriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqPortador(conSimples,
                     Self,
                     edtCodPorOri,
                     edtNomPorOri,
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     edtCodEmp.Text)  then
    Begin
      fValidaCampos(edtCodPorOri,False);
      Self.SelectNext(ActiveControl, True, True);
    End;
  end;
end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmGeraLivroCaixa.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    Key := #0;
    if fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     edtNomPor,
                     nil,
                     chrKey,
                     arrSel)  then
    Begin
      fValidaCampos(edtCodPor,False);
      Self.SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmGeraLivroCaixa.edtCodPorOriExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPorOri, edtNomPorOri, arrPortador, nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmGeraLivroCaixa.mskCodCtaOriExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskCodCtaOri, edtDesCustoOri, arrCentroCusto, fRetNomeConta, Nil, 'do Plano de Contas');
end;

function TfrmGeraLivroCaixa.fConfirmaArquivosGeracao: Boolean;
begin
  Result := (chkCadRec.Checked) Or (chkCadPag.Checked) Or (chkCadRcxx.Checked);

  If (Not Result) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um arquivo para geração.', ['&Ok']);
  End;
end;

procedure TfrmGeraLivroCaixa.pGravaCaixa;
  Var
    qryGen: TUniQuery;

    lstBanTrf: TListaBanTrf;

    LBanTrfDS: TBanTrfDS;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Clear;

    Add('SELECT ');
    Add('  CLI_NOMCLI AS NOMCLI, ');
    Add('  RCX_NUMDUP AS NUMDUP, ');
    Add('  RCX_PARCEL AS PARCEL, ');
    Add('  RCX_CODCLI AS CODCLI, ');
    Add('  RCX_CODOPE AS OPEBAI, ');
    Add('  RCX_DTACAD AS DTAREC, ');
    Add('  RCX_VALDOC AS VALREC, ');
    Add('  RCX_DESCRI AS HISTOR, ');
    Add('  RCX_DINREC AS DINREC, ');
    Add('  RCX_CHQAVI AS CHQAVI, ');
    Add('  RCX_CHQPRE AS CHQPRE, ');
    Add('  RCX_CARREC AS CARREC, ');
    Add('  RCX_ORDREC AS ORDREC, ');
    Add('  RCX_VALFIN AS VALFIN  ');
    Add('FROM ');
    Add('  CADRCXX ');
    Add('INNER JOIN CADCLI ON CLI_CODCLI = RCX_CODCLI');
    Add('WHERE');
    Add('  RCX_ESPDOC IN ("NF", "EL", "IF", "IV", "D1") AND ');
    Add('  RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN AND');
    Add('  IFNULL(RCX_EMPDUP, RCX_CODEMP) = :CODEMP');

    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    Open;

    prgProgresso.Position := 0;
    prgProgresso.Max := RecordCount;
    pnlInfo.Caption := 'Gerando movimento para o Caixa';

    lstBanTrf := TListaBanTrf.Create;

    While Not Eof Do
    Begin
      LBanTrfDS := TBanTrfDS.Create;
      LBanTrfDS.strCodOpe := FieldByName('OPEBAI').AsString;
      LBanTrfDS.strCodEmp := edtCodEmp.Text;
      LBanTrfDS.strDescri := FieldByName('HISTOR').AsString;
      LBanTrfDS.fltValDoc := IIF(FieldByName('VALREC').AsFloat < 0.0, (-1) * FieldByName('VALREC').AsFloat, FieldByName('VALREC').AsFloat);
      LBanTrfDS.fltDinRec := FieldByName('DINREC').AsFloat;
      LBanTrfDS.fltChqAvi := FieldByName('CHQAVI').AsFloat;
      LBanTrfDS.fltChqPre := FieldByName('CHQPRE').AsFloat;
      LBanTrfDS.fltCarRec := FieldByName('CARREC').AsFloat;
      LBanTrfDS.fltOrdRec := FieldByName('ORDREC').AsFloat;
      LBanTrfDS.fltValFin := FieldByName('VALFIN').AsFloat;

      lstBanTrf.Clear;
      lstBanTrf.Add(LBanTrfDS);

      If fEmptyStr(fGravaMovBan(fTiraCaracEspeciais(mskCodCta.Text),
                                edtCodPor.Text,
                                FieldByName('OPEBAI').AsString,
                                FieldByName('DTAREC').AsDateTime,
                                fTime(),
                                FieldByName('NUMDUP').AsString,
                                IIF(FieldByName('VALREC').AsFloat < 0.0, 'D', 'C'),
                                edtCodEmp.Text,
                                IIF(FieldByName('VALREC').AsFloat < 0.0, (-1) * FieldByName('VALREC').AsFloat, FieldByName('VALREC').AsFloat),
                                FieldByName('NOMCLI').AsString,
                                FieldByName('HISTOR').AsString,
                                FieldByName('CODCLI').AsString,
                                '',
                                FieldByName('NUMDUP').AsString,
                                0,
                                FieldByName('PARCEL').AsString,
                                edtCodEmp.Text,
                                '',
                                '',
                                '',
                                Nil,
                                0,
                                0,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                1,
                                True,
                                lstBanTrf)) Then
         Break;

      Next;
      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;

    End;

    prgProgresso.Position := 0;
    pnlInfo.Caption := '';
    FreeAndNil(lstBanTrf);
  End;

  FreeAndNil(qryGen);
end;

end.
