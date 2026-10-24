unit untAbstractConfiguracaoAutomotiva;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untAbstractConfiguracao, AppEvnts, Menus, StdCtrls, EditFocus, ComCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, StrUtils, Uni, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmAbstractConfiguracaoAutomotiva = class(TfrmAbstractConfiguracao)
    chkAcumuladoAbsoluto: TCheckBox;
    grpProdutos: TGroupBox;
    lblProdutos: TLabel;
    edtCodProdut: TEditFocus;
    edtDesProdut: TEditFocus;
    procedure edtCodProdutKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure CarregaProdutos;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit); virtual;
    procedure CarregarConfiguracoes; override;
    procedure SalvarConfiguracoes; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override; 
  public
    { Public declarations }
  end;

var
  frmAbstractConfiguracaoAutomotiva: TfrmAbstractConfiguracaoAutomotiva;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmAbstractConfiguracaoAutomotiva }

procedure TfrmAbstractConfiguracaoAutomotiva.CarregaProdutos;
var
  intCont: Integer;
begin
  for intCont := 0 to ComponentCount - 1 do
  begin
    if Components[intCont] is TEdit then
    begin
      if LeftStr(Components[intCont].Name, 6) = 'edtCod' then
      begin
        if Assigned(FindComponent('edtDes' + RightStr(TEdit(Components[intCont]).Name, 6))) then
          TEdit(FindComponent('edtDes' + RightStr(TEdit(Components[intCont]).Name, 6))).Text :=
            fRetNomProduto(TEdit(Components[intCont]).Text);
      end;
    end;
  end;

end;

procedure TfrmAbstractConfiguracaoAutomotiva.CarregarConfiguracoes;
begin
  Try
    inherited CarregarConfiguracoes;
    conf.pInsereCodigo('ACUABS', 'Formulação acumulada ou absoluta', '2');
    conf.pInsereCodigo('CODPRO', 'Produto para venda', '');

    chkAcumuladoAbsoluto.Checked := IIF(conf.fGet('ACUABS') = '1', True, False);
    edtCodProdut.Text := conf.fGet('CODPRO');
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

procedure TfrmAbstractConfiguracaoAutomotiva.edtCodProdutKeyPress(Sender: TObject; var Key: Char);
var
  edtDesEdt: TEdit;
begin
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
    if Assigned(edtDesEdt) then
      pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmAbstractConfiguracaoAutomotiva.FormShow(Sender: TObject);
begin
  inherited;
  CarregaProdutos;
end;

function TfrmAbstractConfiguracaoAutomotiva.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    CarregaProdutos;
    if Sender = edtCodProdut then
    begin
      if fEmptyStr(edtDesProdut.Text) then
      begin
        fMensagem('ATENÇÃO', Format('O produto [%s] não está cadastrado', [edtCodProdut.Text]), ['OK']);
        Result := False;
      end;
    end;  
  end;  

  if not Result then
    pSetFocus(Sender);
  
end;

procedure TfrmAbstractConfiguracaoAutomotiva.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmAbstractConfiguracaoAutomotiva.SalvarConfiguracoes;
begin
  Try
    inherited SalvarConfiguracoes;
    conf.pSet('ACUABS', IIF(chkAcumuladoAbsoluto.Checked, '1', '2'));
    conf.pSet('CODPRO', edtCodProdut.Text);
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;

end;

end.
