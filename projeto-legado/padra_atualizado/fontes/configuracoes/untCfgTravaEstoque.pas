unit untCfgTravaEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Mask, DBCtrls, DBEditFocus, QColorLabel,
  Buttons, ExtCtrls, EditFocus;

type
  TfrmCfgTravaEstoque = class(TfrmPai)
    pnlCentral: TPanel;
    btnGravar: TBitBtn;
    Label55: TLabel;
    ColorLabel36: TColorLabel;
    Label58: TLabel;
    ColorLabel37: TColorLabel;
    dbeSldVn: TDBEditFocus;
    dbeSldOp: TDBEditFocus;
    Label1: TLabel;
    dbeConEnt: TDBEditFocus;
    ColorLabel1: TColorLabel;
    Label2: TLabel;
    ColorLabel2: TColorLabel;
    dbeVseOrc: TDBEditFocus;
    Label3: TLabel;
    dbeSeSdVn: TDBEditFocus;
    Label4: TLabel;
    dbeSeSdOp: TDBEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure dbeSldVnChange(Sender: TObject);
    procedure dbeSldOpClick(Sender: TObject);
    procedure dbeSldOpChange(Sender: TObject);

  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCfgTravaEstoque: TfrmCfgTravaEstoque;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

{ TfrmCfgTravaEstoque }

function TfrmCfgTravaEstoque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {*****************************************}
  {* VALIDAÇÕES DA ABA TRAVA DO ESTOQUE    *}
  {**************************************MV*}
  If (Sender = dbeSldVn) Or
     (Sender = dbeSldOP) Then
  Begin

    If fEmptyStr((Sender As TDBEdit).Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Opção de Trava deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Copy((Sender As TDBEdit).Text, 1, 1) <> 'A') And
            (Copy((Sender As TDBEdit).Text, 1, 1) <> 'T') And
            (Copy((Sender As TDBEdit).Text, 1, 1) <> 'N') Then
    Begin
      Result := False;
    End;

  End

  Else If (Sender = dbeConEnt) Then
  Begin
    Result := Pos(dbeConEnt.Text, 'SN') > 0;
  End

  Else If (Sender = dbeVseOrc) Then
  Begin
    Result := Pos(dbeVseOrc.Text, 'SN') > 0;
  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmCfgTravaEstoque.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;

end;

procedure TfrmCfgTravaEstoque.dbeSldVnChange(Sender: TObject);
begin
  inherited;
  If (dbeSldVn.Text = 'T') Then
  Begin
    dbeVseOrc.Enabled := True;
    dbeSeSdVn.Enabled := True;
  End
  Else
  Begin
    dbeVseOrc.Enabled := False;
    dbeSeSdVn.Enabled := False;
    If (Assigned(dbeVseOrc.Field)) Then
      dbeVseOrc.Field.AsString := 'N';

    If (Assigned(dbeSeSdVn.Field)) Then
      dbeSeSdVn.Field.AsString := '';

  End;
end;

procedure TfrmCfgTravaEstoque.dbeSldOpClick(Sender: TObject);
begin
  inherited;
  If (dbeSldOp.Text = 'T') Then
  Begin
    dbeSeSdOp.Enabled := True;
  End
  Else
  Begin
    dbeSeSdOp.Enabled := False;
    If (Assigned(dbeSeSdOp.Field)) Then
      dbeSeSdOp.Field.AsString := '';
  End;

end;

procedure TfrmCfgTravaEstoque.dbeSldOpChange(Sender: TObject);
begin
  inherited;
  If (dbeSldOp.Text = 'T') Then
  Begin
    dbeSeSdOp.Enabled := True;
  End
  Else
  Begin
    dbeSeSdOp.Enabled := False;
    If (Assigned(dbeSeSdOp.Field)) Then
      dbeSeSdOp.Field.AsString := '';

  End;
end;

initialization
  RegisterClass(TfrmCfgTravaEstoque);
finalization
  UnRegisterClass(TfrmCfgTravaEstoque);

end.

