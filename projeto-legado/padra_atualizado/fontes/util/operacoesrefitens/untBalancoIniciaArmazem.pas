unit untBalancoIniciaArmazem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untFuncoesConsulta, untTypesSistema, untConsultas,
  untFuncoesSimples;

type
  TfrmBalancoIniciaArmazem = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    Label8: TLabel;
    edtCodAmz: TEditFocus;
    edtDesAmz: TEditFocus;
    procedure edtCodAmzExit(Sender: TObject);
    procedure edtCodAmzKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    arrCodAmz: TConsultasArray;
  public
    { Public declarations }

    blnFinaliza: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

var
  frmBalancoIniciaArmazem: TfrmBalancoIniciaArmazem;

implementation

{$R *.dfm}

Uses
  untCadLote;

procedure TfrmBalancoIniciaArmazem.edtCodAmzExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodAmz, edtDesAmz, arrCodAmz, Nil, fRetNomeArmazem, 'do armazém');

  If Length(arrCodAmz) > 1 Then
    edtDesAmz.Text := fArrCodigosToLista('', arrCodAmz);
end;

procedure TfrmBalancoIniciaArmazem.edtCodAmzKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqArmazem(Self, edtCodAmz, edtDesAmz, nil, Key, arrCodAmz, False) Then
  Begin
    If fValidaCampos(edtCodAmz, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoIniciaArmazem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If blnFinaliza Then
    Begin

      If TCadLot.fFinalizaContagemArmazem Then
        pMensagemOk('Balanço finalizado com sucesso!')

      Else Action := caNone;

    End

    Else If fVerificaCampos Then
    Begin

      If TCadLot.fIniciaContagemArmazem(arrCodAmz) Then
        pMensagemOk('Balanço iniciado com sucesso!')

      Else Action := caNone;

    End

    Else Action := caNone;

  End;

end;

procedure TfrmBalancoIniciaArmazem.FormCreate(Sender: TObject);
begin
  inherited;

  blnFinaliza := False;

end;

procedure TfrmBalancoIniciaArmazem.FormShow(Sender: TObject);
  Var
    strAmzIni: String;
    intNumAmz: Integer;
begin
  inherited;

  If blnFinaliza Then
  Begin
    Caption := 'Finalização de Balanço por armazém';
    edtCodAmz.Enabled := False;

    If TCadLot.fTemContagemArmazem(strAmzIni, intNumAmz) Then
    Begin

      If intNumAmz > 1 Then
      Begin
        edtCodAmz.Text := '';
        edtDesAmz.Text := strAmzIni;
      End Else
      Begin
        edtCodAmz.Text := strAmzIni;
        edtDesAmz.Text := fRetNomeArmazem(strAmzIni);
      End;

    End;
  End;
end;

function TfrmBalancoIniciaArmazem.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If Sender = edtCodAmz Then
    Begin

      If fEmptyStr(edtCodAmz.Text) Then
      Begin
        pMensagemOk('Informe o códido do armazém!');
        Result := False;
      End
      Else If Not (fCampoTabela('AMZ_CODEMP', 'CADAMZ', ['AMZ_CODAMZ', 'AMZ_CODEMP'], [edtCodAmz.Text, VS_StrCodEmp]) = VS_StrCodEmp) Then
      Begin
        pMensagemOk('Armazém informado não pertence a empresa logada.');
        Result := False;
      End
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

end.

