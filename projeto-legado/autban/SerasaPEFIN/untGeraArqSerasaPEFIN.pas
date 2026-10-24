unit untGeraArqSerasaPEFIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, MaskEditFocus, AppEvnts,
  Menus, Buttons, ExtCtrls, Uni, QColorLabel, BitBtnLockedIncrem, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmGeraArqSerasaPEFIN = class(TfrmPai)
    pnlFundo: TPanel;
    lblDtaFin: TLabel;
    lblDtaIni: TLabel;
    pnlTopo: TPanel;
    mskDtaIni1: TMaskEditFocus;
    mskDtaFin1: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    lblCodEmp: TLabel;
    edtNomEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    Label1: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    Label2: TLabel;
    btnGerar: TBitBtnLocked;
    Label3: TLabel;
    Label4: TLabel;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    qryCadEmp: TUniQuery;
    qryCadPor: TUniQuery;

    procedure pCarregaCadEmp;
    procedure pCarregaCadPor;

  public
    { Public declarations }
    intCartei: Integer;

    procedure pGeraDupSerasa;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmGeraArqSerasaPEFIN: TfrmGeraArqSerasaPEFIN;

implementation

uses untFuncoesSimples, untConsultas,
   DB, untGeraArqSerasaPEFINSel, StrUtils;

{$R *.dfm}

procedure TfrmGeraArqSerasaPEFIN.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text  := FormatDateTime('dd/mm/yyyy',VS_Date - 1790);
  mskDtaFin.Text  := FormatDateTime('dd/mm/yyyy',VS_Date - 5);
end;

function TfrmGeraArqSerasaPEFIN.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaIni)Then
    Begin
      If fEmptyStr(mskDtaIni.Text) Then
      Begin
        fMensagem('','A data inicial deve ser preenchida!',['&O K']);
        Result := False;
      End
      Else
      If StrToDate(mskDtaIni.Text) < VS_Date - 1790 Then
      Begin
        fMensagem('','A data inicial deve ser a partir de ' + FormatDateTime('dd/mm/yyyy', VS_Date - 1790) + '!', ['&O K']);
        Result := False;
      End;
    End
    Else
    If (Sender = mskDtaFin) Then
    Begin
      If StrToDate(mskDtaFin.Text) >= VS_Date - 4  Then
      Begin
        fMensagem('','A data Final deve ser até ' + FormatDateTime('dd/mm/yyyy', VS_Date - 5) + '!', ['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        pCarregaCadPor;
        If Not CarregaPortador(edtCodPor.Text) Then
           Result := False
        Else
        If (qryCadPor.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmptyStr(edtCodEmp.Text) And Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmGeraArqSerasaPEFIN.pGeraDupSerasa;
begin
  Try
    pCriarFormularios(TfrmGeraArqSerasaPEFINSel, frmGeraArqSerasaPEFINSel);
    With frmGeraArqSerasaPEFINSel Do
    Begin
      dtaDtaIni := StrToDate(mskDtaIni.Text);
      dtaDtaFin := StrToDate(mskDtaFin.Text);
      strCodEmp := edtCodEmp.Text;
      strEspDoc := edtEspDoc.Text;
      strCodPor := edtCodPor.Text;

      If fGeraDupSerasa Then
        ShowModal;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmGeraArqSerasaPEFIN.pGeraDupSerasa');
  End;
  pFreeAndNil(frmGeraArqSerasaPEFINSel);
end;

procedure TfrmGeraArqSerasaPEFIN.btnGerarClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  {***********************************************************}
  {* DESABILITA O BOTÃO PARA O USUARIO NÃO CLICAR DUAS VEZES *}
  {********************************************************PH*}

  btnGerar.Enabled := False;
  pGeraDupSerasa;
  btnGerar.Enabled := True;
end;


procedure TfrmGeraArqSerasaPEFIN.edtCodEmpKeyPress(Sender: TObject;
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
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraArqSerasaPEFIN.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtCodEmp.Text)) Then
  Begin
    edtNomEmp.Text := 'TODAS';
  End
  Else
  Begin
    pCarregaCadEmp;
    If (qryCadEmp.IsEmpty) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
      pSetFocus(edtCodEmp);
    End;
  End;

end;

procedure TfrmGeraArqSerasaPEFIN.pCarregaCadEmp;
begin
  qryCadEmp.SQL.Clear;
  qryCadEmp.SQL.Add('SELECT * FROM CADEMP WHERE EMP_CODEMP = :CODEMP');
  qryCadEmp.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  qryCadEmp.Open;

  edtNomEmp.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmGeraArqSerasaPEFIN.pCarregaCadPor;
begin
  qryCadPor.SQL.Clear;
  qryCadPor.SQL.Add('SELECT * FROM CADPOR WHERE POR_CODPOR = :CODPOR');
  qryCadPor.ParamByName('CODPOR').AsString := edtCodPor.Text;
  qryCadPor.Open;

  edtDesPor.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmGeraArqSerasaPEFIN.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmGeraArqSerasaPEFIN.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadEmp := fCriaQuery(Self);
  qryCadPor := fCriaQuery(Self);
end;

procedure TfrmGeraArqSerasaPEFIN.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If ActiveControl Is TRadioButton Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmGeraArqSerasaPEFIN.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
End;

procedure TfrmGeraArqSerasaPEFIN.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     TEditFocus(edtDesPor),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     '',
                     False,
                     True) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

End.
