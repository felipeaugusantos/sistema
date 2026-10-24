unit untCadPromocaoBrindesHeranca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadPromocaoBrindesHeranca = class(TfrmPai)
    Panel1: TPanel;
    Label9: TLabel;
    edtDesPro: TEditFocus;
    edtCodPro: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;   Shift: TShiftState);
  private
    { Private declarations }
    procedure pLoadPromocao(strCodPro: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    qryGenPro  : TUniQuery;
    blnConfirma: Boolean;
  end;


implementation

Uses untfuncoesSimples, DB, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadPromocaoBrindesHeranca.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    chrKey: Char;
    arrPromocoes: TConsultasArray;
begin
  chrKey := Key;
  If fPesqPromocoesBrindes(Self, edtCodPro, Nil, qryGenPro, chrKey, arrPromocoes) Then
  Begin
    pLoadPromocao(qryGenPro.FieldByName('PRO_CODPRO').asString);
  End;
end;

procedure TfrmCadPromocaoBrindesHeranca.pLoadPromocao(strCodPro: String);
  Var
    strSQL: String;

begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PROBRI_GER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_CODPRO = :CODPRO ';

  With qryGenPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPRO').Value := strCodPro;
    Open;

    If Not IsEmpty Then
    Begin
      edtCodPro.Text := qryGenPro.FieldByName('PRO_CODPRO').asString;
      edtDesPro.Text := qryGenPro.FieldByName('PRO_DESPRO').asString;
    End
    Else
    Begin
      edtCodPro.Clear;
      edtDesPro.Clear;
      pSetFocus(edtCodPro);
    End;

  End;

end;

procedure TfrmCadPromocaoBrindesHeranca.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmCadPromocaoBrindesHeranca.FormShow(Sender: TObject);
begin
  inherited;
  edtCodPro.Clear;
  edtDesPro.Clear;
end;

procedure TfrmCadPromocaoBrindesHeranca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: btnSairClick(Sender);
  End;
end;

function TfrmCadPromocaoBrindesHeranca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodPro) Then
  Begin

    If (fEmptyStr(edtCodPro.Text)) Then
    Begin
      fMensagem('ATENÇÃO','O Campo Código da Promoção deve ser preenchido!',['&O K']);
      Result := False;
    End
    Else
    Begin
      pLoadPromocao(edtCodPro.Text);

      If fEmptyStr(edtCodPro.Text) Then
        fMensagem('ATENÇÃO','Código da Promoção não encontrado!',['&O K']); 

    End;
    
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

end.

