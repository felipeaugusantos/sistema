unit Contabilidade.View.FechamentoDiaMesIncluir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus,
  untTypesSistema, Contabilidade.Classes.FechamentoDiaMes;

type
  TfrmIncluiFechamentoDiaMes = class(TfrmPaiConfirmaContabilidade)
    Label62: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    mskUltFec: TMaskEditFocus;
    mskNovFec: TMaskEditFocus;
    chkRaiz: TCheckBox;
    mskUltFecCon: TMaskEditFocus;
    Label3: TLabel;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure pAvisarPendenciaContabil;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    ACodEmpresa: String;
    objFechamento: TFechamentoContabilDiaMes;
  end;

implementation

uses
  System.DateUtils, System.StrUtils,
  untConsultas, untFuncoesSimples, UniClientDataSet, Contabilidade.Funcoes,
  Contabilidade.Classes.TListaValidacoesContabeis, Contabilidade.View.ErrosContabeis;

{$R *.dfm}

{ TfrmIncluiFechamentoDiaMes }

procedure TfrmIncluiFechamentoDiaMes.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpresa : TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmIncluiFechamentoDiaMes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOK) Then
  Begin

    If Not fVerificaCampos Then
    Begin
      Action := caNone;
      Exit;
    End;

    try
      pAvisarPendenciaContabil;
    except
      on E: Exception do
      begin
        pMensagensErro(E.Classname + ': ' + E.Message, 'TfrmIncluiFechamentoDiaMes.FormClose');
        Action := caNone;
        Exit;
      end;
    end;

    If (fMensagem('Aviso', 'Confirma o fechamendo do dia ' + mskNovFec.Text + ' para ' +
      IfThen(chkRaiz.Checked, 'todas as empresas da raiz do CNPJ', 'a empresa ' + edtCodEmp.Text + '-' + edtNomEmp.Text) + '?',
      ['&Sim', '&Não'], 1) = 1)
    Then
    Begin
      try
        If objFechamento.fIncluirFechamento(edtCodEmp.Text, StrToDateDef(mskNovFec.Text, 0), chkRaiz.Checked) Then
          fMensagem('', 'Fechamento incluído com sucesso!', ['&O k'])
        Else
          raise TFechamentoInclusaoException.Create('Erro ao incluir registro.');
      except
        on FE: TFechamentoException do
        begin
          fMensagem('ATENÇÃO', FE.Message, ['&O k']);
          Action := caNone;
        end;

        on E: Exception do
        begin
          pMensagensErro(E.Classname + ': ' + E.Message, 'TfrmIncluiFechamentoDiaMes.FormClose');
          Action := caNone;
        end;
      end;
    End

    Else
      Action := caNone;
  End;
end;

procedure TfrmIncluiFechamentoDiaMes.pAvisarPendenciaContabil;
var
  LarrEmpRaiz: TConsultasArray;
  LarrEmp: TArray<string>;
  LdtaFec: TDateTime;
  LintCnt: Integer;
  LcdsPendencias: TUniClientDataSet;
begin
  // So avisa: o fechamento diario/mensal segue com ou sem pendencia (Req. 470760).
  LdtaFec := StrToDateDef(mskNovFec.Text, 0);

  if chkRaiz.Checked then
  begin
    LarrEmpRaiz := fObtemEmpresasFiliais(edtCodEmp.Text);
    SetLength(LarrEmp, Length(LarrEmpRaiz));
    for LintCnt := 0 to High(LarrEmpRaiz) do
      LarrEmp[LintCnt] := LarrEmpRaiz[LintCnt].strCodigo;
  end
  else
    LarrEmp := [edtCodEmp.Text];

  if not TPendenciaContabil.fExiste(LarrEmp, LdtaFec) then
    Exit;

  if fMensagem('Aviso', 'Existem lançamentos com erros que devem ser corrigidos. Deseja Visualizar esses lançamentos?',
               ['&Sim', '&Não'], 1) = 2 then
    Exit;

  LcdsPendencias := TPendenciaContabil.fListar(LarrEmp, nil, 0, LdtaFec);
  try
    TfrmErrosContabil.pExibir(LcdsPendencias);
  finally
    FreeAndNil(LcdsPendencias);
  end;
end;

procedure TfrmIncluiFechamentoDiaMes.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := ACodEmpresa;

  If Not ACodEmpresa.IsEmpty Then
    fValidaCampos(edtCodEmp, True);

  if edtCodEmp.CanFocus then
    pSetFocus(edtCodEmp);
end;

function TfrmIncluiFechamentoDiaMes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LData: TDate;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe a empresa para o fechamento!', ['&O k']);
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&O k']);
        End Else

        If Not fEmpresaAtiva(edtCodEmp.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Empresa inativa no Cadastro de Empresas!', ['&O k']);
        End;

        LData := objFechamento.fGetDataUltimoFechamento(edtCodEmp.Text);
        If LData > 0 Then
        Begin
          mskUltFec.Text := FormatDateTime('DD/MM/YYYY', LData);
        End Else
        Begin
          mskUltFec.Clear;
        End;

        LData := objFechamento.fGetDataUltimoFecCon(edtCodEmp.Text);
        If LData > 0 Then
        Begin
          mskUltFecCon.Text := FormatDateTime('DD/MM/YYYY', LData);
        End Else
        Begin
          mskUltFecCon.Clear;
        End;
      End;
    End
    Else If (Sender = mskNovFec) Then
    Begin
      If fEmptyDate(mskNovFec.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe a data do fechamento!', ['&O k']);
      End

      Else If (Not fEmptyDate(mskUltFec.Text)) And (StrToDateDef(mskNovFec.Text,0) <= StrToDateDef(mskUltFec.Text,0)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A data do fechamento deve ser maior que o último fechamento diário/mensal (' + mskUltFec.Text + ')!', ['&O k']);
      End

      Else If (Not fEmptyDate(mskUltFecCon.Text)) And (StrToDateDef(mskNovFec.Text,0) <= StrToDateDef(mskUltFecCon.Text,0)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A data do fechamento deve ser maior que o último fechamento contábil (' + mskUltFecCon.Text + ')!', ['&O k']);
      End

      Else If StrToDateDef(mskNovFec.Text,0) >= VS_Date Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A data do fechamento deve ser menor que a data atual!', ['&O k']);
      End

      Else mskNovFec.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(mskNovFec.Text,0));
    End;
  End;


  If (Not Result) Then
  Begin
    If (Sender = mskNovFec) And mskNovFec.ReadOnly Then
      pSetFocus(edtCodEmp)
    Else
      pSetFocus(Sender);
  End;
end;

end.
