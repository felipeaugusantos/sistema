unit untCadDacUni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Uni, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  DB, Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadDacUni = class(TfrmPai)
    dbgUniDac: TDBGridCitel;
    Label1: TLabel;
    dbgCadUni: TDBGridCitel;
    Label2: TLabel;
    btnAdicionar: TSpeedButton;
    btnRemover: TSpeedButton;
    dbgRelacao: TDBGridCitel;
    Label3: TLabel;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
  private
    { Private declarations }
    qryDac_CadUni: TUniQuery;
    dstDac_CadUni: TDataSource;
    qryCadUni : TUniQuery;
    dstCadUni : TDataSource;
    qryRelaca : TUniQuery;
    dstRelaca : TDataSource;
  public
    { Public declarations }
  end;

var
  frmCadDacUni: TfrmCadDacUni;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadDacUni.FormCreate(Sender: TObject);
begin
  inherited;
  qryDac_CadUni := fCriaQuery(Self);
  qryDac_CadUni.SQL.Text := 'SELECT DISTINCT BAS_UNIDAD AS "Unidade" FROM DAC_CADBAS';
  qryDac_CadUni.Open;
  dstDac_CadUni := fCriaDataSource(qryDac_CadUni);
  dbgUniDac.DataSource := dstDac_CadUni;

  qryCadUni := fCriaQuery(Self);
  qryCadUni.SQL.Text := 'SELECT UNI_CODUNI AS "UN", UNI_DESUNI AS "Descrição" FROM CADUNI ORDER BY UNI_DESUNI';
  qryCadUni.Open;
  dstCadUni := fCriaDataSource(qryCadUni);
  dbgCadUni.DataSource := dstCadUni;

  qryRelaca := fCriaQuery(Self);
  qryRelaca.SQL.Text := 'SELECT * FROM DAC_UNIDAC';
  qryRelaca.Open;
  dstRelaca := fCriaDataSource(qryRelaca);
  dbgRelacao.DataSource := dstRelaca;
  
  dbgUniDac.Columns[0].Width  := 71;
  dbgCadUni.Columns[1].Width  := 132;
  dbgRelacao.Columns[1].Width := 117;
end;

procedure TfrmCadDacUni.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  //
end;

procedure TfrmCadDacUni.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If not qryRelaca.Locate('DAC_UNIDAC', qryDac_CadUni.FieldByName('Unidade').AsString, []) Then
  Begin
    qryRelaca.Insert;
    qryRelaca.FieldByName('DAC_UNIDAC').AsString := qryDac_CadUni.FieldByName('Unidade').AsString;
    qryRelaca.FieldByName('DAC_UNIAUT').AsString := qryCadUni.FieldbyName('UN').AsString;
    qryRelaca.FieldByName('DAC_CODEMP').AsString := VS_strCodEmp;
    qryRelaca.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DAC_UNIDAC', VS_strCodEmp);
    qryRelaca.Post;
  End;
end;

procedure TfrmCadDacUni.btnRemoverClick(Sender: TObject);
begin
  inherited;
  qryRelaca.Delete;
end;

end.
