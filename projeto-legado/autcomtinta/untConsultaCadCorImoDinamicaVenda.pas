unit untConsultaCadCorImoDinamicaVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, Mask,
  DBCtrls, DBEditFocus;

type
  TfrmConsultaCadCorImoDinamicaVenda = class(TfrmConsultaComp)
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFiltro1Change(Sender: TObject);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadCorImoDinamicaVenda: TfrmConsultaCadCorImoDinamicaVenda;

implementation

uses untFuncoes, untFuncoesSimples;

{$R *.dfm}

{ TfrmConsultaCadCorImoDinamicaVenda }

procedure TfrmConsultaCadCorImoDinamicaVenda.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadCorImoDinamicaVenda.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmConsultaCadCorImoDinamicaVenda.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadCorImoDinamicaVenda.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadCorImoDinamicaVenda.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadCorImoDinamicaVenda.btnExecutaTarefaClick(
  Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' ' + VS_strCodEmp + ' TfrmCadCorImoNovasFormulas', False);
end;

end.
