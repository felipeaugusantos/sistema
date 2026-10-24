unit untHerancaFeriado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  BitBtnLockedIncrem, ExtCtrls, untCadFer;

type
  TfrmHerancaFeriado = class(TfrmPai)
    Panel1: TPanel;
    btnConfirma: TBitBtnLocked;
    gpbHeranca: TGroupBox;
    Label9: TLabel;
    edtAnoBase: TEditFocus;
    Label1: TLabel;
    edtNovoAno: TEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    objCadFer: TCadFer;
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmHerancaFeriado: TfrmHerancaFeriado;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmHerancaFeriado }

procedure TfrmHerancaFeriado.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    If objCadFer.fGeraFeriadoByAnoBaseToNovoAno(edtAnoBase.Text, edtNovoAno.Text) Then
    Begin
      fMensagem('', 'Cadastro(s) do(s) feriado(s) realizado(s) com sucesso!!', ['&O K']);
      Close;
    End;
  End;
end;

procedure TfrmHerancaFeriado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Assigned(objCadFer.qryTabela) Then
    FreeAndNil(objCadFer.qryTabela);

  If Assigned(objCadFer) Then
    FreeAndNil(objCadFer);
end;

procedure TfrmHerancaFeriado.FormCreate(Sender: TObject);
begin
  inherited;
  
  objCadFer := TCadFer.Create(Self);
end;

function TfrmHerancaFeriado.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtAnoBase) Then
    Begin
      If fEmptyStr(edtAnoBase.Text) Then
      Begin
        fMensagem('Atenção', 'Defina um ano base.', ['&O K']);
        Result := False;
      End
      Else If Not objCadFer.fExisteFerByAno(edtAnoBase.Text) Then
      Begin
        fMensagem('Atenção', 'Não existe(m) feriado(s) cadastrado(s) para o Ano Base escolhido!', ['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtNovoAno) Then
    Begin
      If fEmptyStr(edtNovoAno.Text) Then
      Begin
        fMensagem('Atenção', 'Defina um ano novo.', ['&O K']);
        Result := False;
      End
      Else If edtAnoBase.Text >= edtNovoAno.Text Then
      Begin
        fMensagem('Atenção', 'O ano novo precisa ser maior que o ano base.', ['&O K']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
