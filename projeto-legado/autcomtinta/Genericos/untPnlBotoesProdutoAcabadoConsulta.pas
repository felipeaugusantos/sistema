unit untPnlBotoesProdutoAcabadoConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Uni, UniClientDataSet, untUniQueryDataSetWrapper, untIDataSet,
  untConfiguraConsulta;

type
  TfrmPnlBotoesProdutoAcabadoConsulta = class(TForm)
    btnEstoqueLojas: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEstoqueLojasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qryConsulta: TUniClientDataSet;
    cdsConsulta: TUniClientDataSet;

    FobjConfConsulta: TConfiguraConsulta;

    constructor Create; reintroduce;
    function GetDataSetConsulta: IDataSet;

  end;

  TfrmPnlBotoesProdutoAcabadoConsultaClass = class of TfrmPnlBotoesProdutoAcabadoConsulta;

var
  frmPnlBotoesProdutoAcabadoConsulta: TfrmPnlBotoesProdutoAcabadoConsulta;

implementation

uses
  untSaldosLojasProdutosAcabados, untFuncoesGen;

{$R *.dfm}

{ TfrmPnlBotoesProdutoAcabadoConsulta }

procedure TfrmPnlBotoesProdutoAcabadoConsulta.btnEstoqueLojasClick(Sender: TObject);
var
  frmSaldosLojasProdutosAcabados : TfrmSaldosLojasProdutosAcabados;
begin
  pCriarFormularios(TfrmSaldosLojasProdutosAcabados, frmSaldosLojasProdutosAcabados);

  if FobjConfConsulta.fPossuiFiltro then
    frmSaldosLojasProdutosAcabados.pCdsFiltro(cdsConsulta);

  frmSaldosLojasProdutosAcabados.pMostrarSaldoLojas;
  frmSaldosLojasProdutosAcabados.ShowModal;

end;

constructor TfrmPnlBotoesProdutoAcabadoConsulta.Create;
begin
 Inherited Create(Nil);
end;

procedure TfrmPnlBotoesProdutoAcabadoConsulta.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  case key of
    VK_F6 :
      Begin
        btnEstoqueLojas.Click;
        Key := 0;
      End;
    VK_ESCAPE :
      Begin
        Close;
        Key := 0;
      End;
  end;

end;

procedure TfrmPnlBotoesProdutoAcabadoConsulta.FormShow(Sender: TObject);
begin
  qryConsulta:= cdsConsulta;
end;

function TfrmPnlBotoesProdutoAcabadoConsulta.GetDataSetConsulta: IDataSet;
begin
  Result := TUniQueryDataSetWrapper.Create(qryConsulta);
end;

end.
