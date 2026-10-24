{*********************************************************}
{* BAIXA DE ORDEM DE PRODUÇÃO                            *}
{*                                                       *}
{* DATA......: 23/10/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untBaiOrdPro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, untOrdPro,
  AppEvnts;

type
  TfrmBaiOrdPro = class(TfrmPai)
    pnlOrdPro: TPanel;
    Label3: TLabel;
    edtOrdPro: TEditFocus;
    pnlDadCli: TPanel;
    pnlConferido: TPanel;
    edtCliente: TEditFocus;
    Label1: TLabel;
    edtProduto: TEditFocus;
    Label2: TLabel;
    edtObs001: TEditFocus;
    Label4: TLabel;
    edtObs002: TEditFocus;
    edtProduzir: TEditFocus;
    Label5: TLabel;
    edtProduzido: TEditFocus;
    Label6: TLabel;
    edtConfPor: TEditFocus;
    Label7: TLabel;
    btnGravar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edtOrdProKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pLimpaCampos;
    procedure edtOrdProExit(Sender: TObject);
  private
    { Private declarations }
    objOrdPro: TOrdPro;

    function fValidaEdtOrdPro: Boolean;
    function fValidaEdtProduzido: Boolean;

    procedure pCarregaDados;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmBaiOrdPro: TfrmBaiOrdPro;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

{ TfrmBaiOrdPro }

function TfrmBaiOrdPro.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {****************************}
  {* VALIDA ORDEM DE PRODUCAO *}
  {*************************AF*}
  If (Sender = edtOrdPro) Then
    Result := fValidaEdtOrdPro

  {*******************************}
  {* VALIDA QUANTIDADE PRODUZIDA *}
  {****************************AF*}
  Else If (Sender = edtProduzido) Then
    Result := fValidaEdtProduzido;

  If Not Result Then
    Sender.SetFocus;

end;

procedure TfrmBaiOrdPro.FormCreate(Sender: TObject);
begin
  inherited;

  Try

    objOrdPro := TOrdPro.Create(Self);

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmBaiOrdPro.FormCreate]');
      Close;
    End;
  End;

end;


{**************************************}
{* CARREGA DADOS DOS EDTS             *}
{***********************************AF*}
procedure TfrmBaiOrdPro.pCarregaDados;
begin
  edtCliente.Text   := objOrdPro.strCodCli + ' - ' + objOrdPro.strDesCli;
  edtProduto.Text   := objOrdPro.strCodPro + ' - ' + objOrdPro.strDesIte;
  edtObs001.Text    := objOrdPro.strObs001;
  edtObs002.Text    := objOrdPro.strObs002;
  edtProduzir.Text  := objOrdPro.strQtdApr;
end;

{**************************************}
{* VALIDA CAMPO EDTORDPRO             *}
{***********************************AF*}
function TfrmBaiOrdPro.fValidaEdtOrdPro: Boolean;
begin

  Try
    Result := True;

    If fEmptyStr(edtOrdPro.Text) Then
    Begin
      fMensagem('','O campo ordem de produção deve ser digitado!', ['&OK']);
      Result := False;
    End
    Else
    Begin

      If objOrdPro.fCarregaOrdPro(edtOrdPro.Text) Then
        pCarregaDados

      Else
      Begin
        fMensagem('','Ordem de produção não encontrada!',['&OK']);
        Result := False;
      End;

    End;

  Except
    Result := False;
  End;

end;

{**************************************}
{* VALIDA CAMPO EDTPRODUZIDO          *}
{***********************************AF*}
function TfrmBaiOrdPro.fValidaEdtProduzido: Boolean;
begin

  Try
    Result := True;

    If fEmptyStr(edtProduzido.Text) Then
    Begin
      fMensagem('','O campo produzido deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else
    Begin

      If fStrToFloat(edtProduzido.Text) <= 0 Then
      Begin
        fMensagem('','A quantidade produzida deve ser maior que zero!', ['&OK']);
        Result := False;
      End;
{
      Else If fStrToFloat(edtProduzido.Text) > fStrToFloat(edtProduzir.Text) Then
      Begin
        fMensagem('','A quantidade produzida deve ser menor ou igual a quantidade a produzir!', ['&OK']);
        Result := False;
      End;
}
    End;

  Except
    Result := False;
  End;

end;

procedure TfrmBaiOrdPro.edtOrdProKeyPress(Sender: TObject; var Key: Char);
  Var
    stlCamIndPro: TStringList;
    stlDesIndPro: TStringList;
    strSQL      : String;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    stlCamIndPro := TStringList.Create;
    stlDesIndPro := TStringList.Create;

    strSQL := '';
    strSQL := strSQL + 'SELECT                   ';
    strSQL := strSQL + '  MOVPRO.AUTOINCREM,     ';
    strSQL := strSQL + '  PRO_CODPRO AS "Ord. Prod.",   ';
    strSQL := strSQL + '  PRO_DTAPRO AS "Dta Prev.",    ';
    strSQL := strSQL + '  ITE_DESITE AS "Produto",      ';
    strSQL := strSQL + '  FORMAT(PRO_QTDAPR - IFNULL(PRO_QTDPRO,0),2) AS "Quantidade"    ';
    strSQL := strSQL + 'FROM                     ';
    strSQL := strSQL + '  MOVPRO                 ';
    strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = PRO_CODITE ';
    strSQL := strSQL + 'WHERE                    ';
    strSQL := strSQL + '  PRO_DTABAI IS NULL AND ';
    strSQL := strSQL + '  PRO_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    stlCamIndPro.Add('PRO_CODPRO');
    stlCamIndPro.Add('PRO_DTAPRO');
    stlCamIndPro.Add('ITE_DESITE');

    stlDesIndPro.Add('Ord. Prod.');
    stlDesIndPro.Add('Dta Prev.');
    stlDesIndPro.Add('Produto');

    If pConsultaComp(Self, objOrdPro.qryOrdPro, 'MOVPRO', strSQL, stlCamIndPro, stlDesIndPro) Then
    Begin

      objOrdPro.pAtuDados;
      edtOrdPro.Text := objOrdPro.strCodPro;

      If fValidaCampos(edtOrdPro) Then
        SelectNext(ActiveControl, True, True);

    End;

    FreeAndNil(stlCamIndPro);
    FreeAndNil(stlDesIndPro);

  End;
end;

procedure TfrmBaiOrdPro.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    objOrdPro.pBaixaOrdPro(StrToFloatDef(edtProduzido.Text,0), edtConfPor.Text);
    
    pLimpaCampos;
  End;

end;

procedure TfrmBaiOrdPro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: If Not fEmptyStr(edtOrdPro.Text) Then
               Begin
                 pLimpaCampos;
                 Key := 0;
               End;
  End;

end;

procedure TfrmBaiOrdPro.pLimpaCampos;
Begin

  edtOrdPro.Clear;
  edtCliente.Clear;
  edtProduto.Clear;
  edtObs001.Clear;
  edtObs002.Clear;
  edtProduzir.Clear;
  edtProduzido.Clear;
  edtConfPor.Clear;
  edtOrdPro.SetFocus;

End;

procedure TfrmBaiOrdPro.edtOrdProExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtOrdPro.Text) Then
    edtProduzido.Text := objOrdPro.strQtdApr;

end;

end.

