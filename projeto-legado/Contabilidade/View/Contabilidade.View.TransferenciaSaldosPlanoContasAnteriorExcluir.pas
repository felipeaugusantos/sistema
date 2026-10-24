unit Contabilidade.View.TransferenciaSaldosPlanoContasAnteriorExcluir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus;

type
  TfrmTransferenciaSaldosPlanoContasAnteriorExcluir = class(TfrmPaiConfirmaContabilidade)
    Label15: TLabel;
    edtEmpLan: TEditFocus;
    edtNomEmp: TEditFocus;
    Label1: TLabel;
    edtCompet: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtEmpLanKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FstrCodEmp: String ;
    FstrCompet: String ;
    FblnConfirma: Boolean ;
    function fRetornaSomenteNumerosCompetencia: String ;
  public
    { Public declarations }
    function fValidarDadosInformados: Boolean ;
    property CodEmp: String read FstrCodEmp;
    property Compet: String read FstrCompet;
    property Confirma: Boolean read FblnConfirma;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, strUtils ;

{$R *.dfm}

procedure TfrmTransferenciaSaldosPlanoContasAnteriorExcluir.btnConfirmaClick(
  Sender: TObject);
begin

  if not fValidarDadosInformados then
    Exit ;

  FblnConfirma := True ;

  FstrCodEmp := edtEmpLan.Text ;
  FstrCompet := fRetornaSomenteNumerosCompetencia ;

  Close ;

end;

procedure TfrmTransferenciaSaldosPlanoContasAnteriorExcluir.edtEmpLanKeyPress(
  Sender: TObject; var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpLan, edtNomEmp, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpLan) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTransferenciaSaldosPlanoContasAnteriorExcluir.FormCreate(
  Sender: TObject);
begin
  inherited;
  FstrCodEmp := '' ;
  FstrCompet := '' ;
  FblnConfirma := False ;
end;

function TfrmTransferenciaSaldosPlanoContasAnteriorExcluir.fRetornaSomenteNumerosCompetencia: String;
begin
  Result := Trim(ReplaceStr(edtCompet.Text, '/', '')) ;
end;

function TfrmTransferenciaSaldosPlanoContasAnteriorExcluir.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmpLan) Then
    Begin
      if fEmptyStr(edtEmpLan.Text) then
      begin
        edtNomEmp.Clear;
        Result := True;
      end
      else
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpLan.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        end;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmTransferenciaSaldosPlanoContasAnteriorExcluir.fValidarDadosInformados: Boolean;
var
  LstrCompet: String ;
begin
  Result := False ;
  LstrCompet := fRetornaSomenteNumerosCompetencia ;

  if fEmptyStr(edtEmpLan.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Empresa não informada!', ['&Ok']);
    pSetFocus(edtEmpLan);
    Exit ;
  end ;

  if fEmptyStr(LstrCompet) then
  begin
    fMensagem('ATENÇÃO!', 'Competência não informada!', ['&Ok']);
    pSetFocus(edtCompet);
    Exit ;
  end ;

  if Length(LstrCompet) <> 6 then
  begin
    fMensagem('ATENÇÃO!', 'Competência inválida!', ['&Ok']);
    pSetFocus(edtCompet);
    Exit ;
  end ;

  if Not fVerificaCampos then
    Exit ;

  Result := True ;
end;

end.
