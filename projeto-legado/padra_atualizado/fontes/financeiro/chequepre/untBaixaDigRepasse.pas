{***************************}
{* qryConFor -> CADFOR     *}
{************************JB*}

unit untBaixaDigRepasse;

interface

uses
  Classes, Controls,
  StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, untFechamentoFinanceiro;

type
  TfrmBaixaDigRepasse = class(TfrmPaiSimples)
    Label2: TLabel;
    mskDtaRep: TMaskEditFocus;
    Label1: TLabel;
    edtObsRep: TEditFocus;
    Label3: TLabel;
    edtCodFor: TEditFocus;
    pnlConfirma: TPanel;
    edtNomFor: TEditFocus;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
    qryConFor: TUniQuery;
    dtaDtaMinima : TDateTime;
    objFechamento: TFechamentoFinanceiro;

    procedure pCarregaFornecedor;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strForRep: String;
    strObsRep: String;
    dtaDtaRep: TDateTime;
    procedure pSetDataMinima(data:TDateTime);
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmBaixaDigRepasse }

function TfrmBaixaDigRepasse.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodFor) Then
    Begin
      If (edtCodFor.Visible) And (edtCodFor.Enabled) Then
      Begin
        If fEmptyStr(edtCodFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Fornecedor ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaFornecedor;
          If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = mskDtaRep) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaRep.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do Repasse deve ser preenchida!', ['&O k']);
        Result := False;
      End;

      if dtaDtaMinima > 0 then
      begin
        fMensagem('ATENÇÃO!', 'A Data mínima aceita para Repasse deve ser ' + DateTimeToStr(dtaDtaMinima), ['&O k']);
        Result := False;
      end;

      //FECHAMENTO FINANCEIRO
      if Result then
        if objFechamento.FechamentoFinanceiroJaRealizado(VS_StrCodEmp, StrToDate(mskDtaRep.Text)) then
          Result := False;
    End

    Else If (Sender = edtObsRep) Then
    Begin

      If fEmptyStr(edtObsRep.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Observação do depósito deve ser preenchida!', ['&O k']);
        Result := False;
      End;
{      Else
      Begin
        blnConfirma := True;
        strForRep := edtCodFor.Text;
        dtaDtaRep := StrToDate(mskDtaRep.Text);
        strObsRep := edtObsRep.Text;
        Close;
      End;}

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaDigRepasse.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmBaixaDigRepasse.pSetDataMinima(data: TDateTime);
begin
  dtaDtaMinima := data;
end;

procedure TfrmBaixaDigRepasse.FormCreate(Sender: TObject);
begin
  inherited;
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
end;

procedure TfrmBaixaDigRepasse.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaDigRepasse.FormShow(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodFor.Text) Then
  begin
    pCarregaFornecedor;
    pSetFocus(edtObsRep);
  end;
end;

procedure TfrmBaixaDigRepasse.btnCancelaDadosClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBaixaDigRepasse.btnConfirmaDadosClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    strForRep := edtCodFor.Text;
    dtaDtaRep := StrToDate(mskDtaRep.Text);
    strObsRep := edtObsRep.Text;
    Close;
  End;
end;

end.

