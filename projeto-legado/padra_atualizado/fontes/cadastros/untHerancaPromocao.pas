unit untHerancaPromocao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmHerancaPromocao = class(TfrmPai)
    Panel1: TPanel;
    Label9: TLabel;
    edtDesPro: TEditFocus;
    edtCodPro: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    procedure pLoadPromocao(strCodPro: String);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
    qryGenPro  : TUniQuery;
    blnConfirma: Boolean;
    strTabTmp  : String;

  end;

var
  frmHerancaPromocao: TfrmHerancaPromocao;

implementation

Uses untfuncoesSimples, DB, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmHerancaPromocao.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    chrKey: Char;
    arrPromocoes: TConsultasArray;

begin

  {*******************************}
  {* NOVA CONSULTA DE PROMOÇOES *}
  {****************************AC*}

  chrKey := Key;
  If fPesqPromocoes(Self, edtCodPro, Nil, qryGenPro, chrKey, arrPromocoes) Then
  Begin
    pLoadPromocao(qryGenPro.FieldByName('PRO_CODPRO').asString);
  End;

end;

procedure TfrmHerancaPromocao.pLoadPromocao(strCodPro: String);
  Var
    strSQL: String;

begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPRO ';
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

procedure TfrmHerancaPromocao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  blnConfirma := True;
  Close;

end;

procedure TfrmHerancaPromocao.FormShow(Sender: TObject);
begin
  inherited;

  edtCodPro.Clear;
  edtDesPro.Clear;

end;

procedure TfrmHerancaPromocao.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodPro);
end;

procedure TfrmHerancaPromocao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: btnSairClick(Sender);

  End;

end;

function TfrmHerancaPromocao.fValidaCampos(Sender: TWinControl;
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

