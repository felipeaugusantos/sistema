unit Contabilidade.View.IncluirDeExercicio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiConfirmaContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLabel, EditFocus,
  Contabilidade.Classes.TDemonstracaoMutacaoPatrimonioLiquido,
  Contabilidade.Interfaces;

type
  TfrmIncluirDeExercicio = class(TfrmPaiConfirmaContabilidade)
    gbExercicio: TcxGroupBox;
    cbExercicio: TcxComboBox;
    cxLabel8: TcxLabel;
    cxLabel7: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtEmpSelExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FExercicio: Integer ;
    FCodEmpresa: String ;
    FConfirmado: Boolean ;
    FTipo: TTipoExercicio ;
    FListarExercicioExterno: TListarExerciciosDemonstracao ;
    function fListarExerciciosInterno(const ACodEmp: String): TStringList ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property Exercicio: Integer read FExercicio ;
    property CodEmpresa: String read FCodEmpresa ;
    property Confirmado: Boolean read FConfirmado ;
    property Tipo: TTipoExercicio read FTipo write FTipo ;
    property funcListarExercicio: TListarExerciciosDemonstracao read FListarExercicioExterno write FListarExercicioExterno ;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, Contabilidade.Consultas, untConsultas, untTypesSistema;

procedure TfrmIncluirDeExercicio.btnConfirmaClick(Sender: TObject);
begin
  if fEmptyStr(edtEmpSel.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Empresa não informada!', ['&Ok']);
    pSetFocus(edtEmpSel);
    exit ;
  end ;

  if fEmptyStr(cbExercicio.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!', ['&Ok']);
    pSetFocus(cbExercicio);
    exit ;
  end ;

  FConfirmado := True ;
  FExercicio  := StrToIntDef(cbExercicio.Text, 0) ;
  FCodEmpresa := edtEmpSel.Text ;

  close ;
end;

procedure TfrmIncluirDeExercicio.edtEmpSelExit(Sender: TObject);
var
  LlstExercicio : TStringList ;
begin
  inherited;
  LlstExercicio := fListarExerciciosInterno(TEditFocus(Sender).Text) ;
  try
    cbExercicio.Properties.Items.Assign(LlstExercicio);
    cbExercicio.ItemIndex := 0 ;
  finally
    FreeAndNil(LlstExercicio) ;
  end;
end;

procedure TfrmIncluirDeExercicio.edtEmpSelKeyPress(Sender: TObject;
  var Key: Char);
var
  LEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, LEmpSel, True) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmIncluirDeExercicio.fListarExerciciosInterno(
  const ACodEmp: String): TStringList;
begin
  if Assigned(FListarExercicioExterno) then
    Result := FListarExercicioExterno(ACodEmp)
  else
    Result := TDemonstracaoMutacaoPatrimonioLiquidoExercicio.Listar(ACodEmp, FTipo) ;
end;

procedure TfrmIncluirDeExercicio.FormCreate(Sender: TObject);
begin
  inherited;
  FListarExercicioExterno := Nil ;
  FExercicio  := 0 ;
  FCodEmpresa := '' ;
  FConfirmado := False ;
  FTipo := teParametro ;
end;

procedure TfrmIncluirDeExercicio.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtEmpSel);
end;

function TfrmIncluirDeExercicio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmpSel) Then
    begin
      if not fEmptyStr(edtEmpSel.Text) then
      Begin
        edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text], False);
        if fEmptyStr(edtNomEmpSel.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel.Clear;
        edtEmpSel.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End ;
    end ;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
