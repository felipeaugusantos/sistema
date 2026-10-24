unit untFatGeracaoMultiplasOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, EditFocus, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, untConsertoEquipamento;

type
  TfrmFatGeracaoMultiplasOS = class(TfrmPaiSimples)
    Panel1: TPanel;
    FlwPnlButtons: TFlowPanel;
    btnConfirmar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    dbgGridEquOS: TDBGridCitel;
    pnlTopo: TPanel;
    Label1: TLabel;
    edtQtdeOS: TEditFocus;
    dtsGrid: TDataSource;
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtQtdeOSKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbgGridEquOSKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function fValidaNSerie: Boolean;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strMarca   : String;
    objConEqu  : TConEqu;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatGeracaoMultiplasOS.btnCancelarClick(Sender: TObject);
begin
  inherited;

  blnConfirma := False;
  Close;
end;

procedure TfrmFatGeracaoMultiplasOS.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  if (objConEqu.cdsGerMOS.IsEmpty) then
  begin
    fMensagem('ATENÇÃO!', 'Informe a quantidade de equipamentos.', ['&OK']);
    Exit;
  end;

  if (not fValidaNSerie) then
  begin
    fMensagem('ATENÇÃO!', 'O Número de Série deve ser informado em todos os equipamentos!', ['&OK']);
    Exit;
  end;

  if (fMensagem('AVISO', 'Confirma gravação das ordens de serviço?', ['&Sim', '&Não']) = 2) then
    Exit;

  blnConfirma := True;
  Close;
end;

procedure TfrmFatGeracaoMultiplasOS.dbgGridEquOSKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := AnsiUpperCase(Key)[1];
end;

procedure TfrmFatGeracaoMultiplasOS.edtQtdeOSKeyPress(Sender: TObject; var Key: Char);
var
  intCont : Integer;
  strEquip: String;
begin
  inherited;

  if (Key = #13) then
  begin
    if fEmptyStr(edtQtdeOS.Text) or (edtQtdeOS.Text = '0') then
    begin
      fMensagem('ATENÇÃO!', 'Informe a quantidade de equipamentos acima de 0.', ['&OK']);
      pSetFocus(edtQtdeOS);
      Exit;
    end;

    strEquip := objConEqu.strCodEqu + ' - ' + fRetNomEquipamentoOS(objConEqu.strCodEqu);
    objConEqu.cdsGerMOS.EmptyDataSet;

    objConEqu.cdsGerMOS.Insert;
    objConEqu.cdsGerMOS.FieldByName('SEQUEN').AsString := '001';
    objConEqu.cdsGerMOS.FieldByName('CODEQU').AsString := strEquip;
    objConEqu.cdsGerMOS.FieldByName('CODMAR').AsString := strMarca;
    objConEqu.cdsGerMOS.FieldByName('NSERIE').AsString := objConEqu.strNSerie;
    objConEqu.cdsGerMOS.FieldByName('NUMPAT').AsString := objConEqu.strNumPat;
    objConEqu.cdsGerMOS.Post;

    for intCont := 2 to StrToInt(edtQtdeOS.Text) do
    begin
      objConEqu.cdsGerMOS.Insert;
      objConEqu.cdsGerMOS.FieldByName('SEQUEN').AsString := fPadL(intCont.ToString, 3, '0');
      objConEqu.cdsGerMOS.FieldByName('CODEQU').AsString := strEquip;
      objConEqu.cdsGerMOS.FieldByName('CODMAR').AsString := strMarca;
      objConEqu.cdsGerMOS.FieldByName('NSERIE').AsString := '';
      objConEqu.cdsGerMOS.FieldByName('NUMPAT').AsString := '';
      objConEqu.cdsGerMOS.Post;
    end;

    objConEqu.cdsGerMOS.First;
  end;
end;

procedure TfrmFatGeracaoMultiplasOS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (Key = VK_F10) then
  begin
    if (btnConfirmar.Enabled) then
      btnConfirmar.Click;
  end;
end;

procedure TfrmFatGeracaoMultiplasOS.FormShow(Sender: TObject);
begin
  inherited;
  dtsGrid.DataSet := objConEqu.cdsGerMOS;
end;

function TfrmFatGeracaoMultiplasOS.fValidaNSerie: Boolean;
begin
  Result := True;

  if (not fCfgSis('NSROBG', varBoolean)) then
    Exit;

  if objConEqu.cdsGerMOS.Locate('NSERIE', '', []) then
    Result := False;
end;

end.
