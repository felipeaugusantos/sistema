unit untConsultaCadCorImo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadCorImo = class(TfrmConsultaComp)
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadCorImo: TfrmConsultaCadCorImo;

implementation

{$R *.dfm}

{ TfrmConsultaCadCorImo }

procedure TfrmConsultaCadCorImo.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadCorImo.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;

  (qryConsulta.FieldByName('Preço Custo') As TFloatField).DisplayFormat         := '#,##0.00';
  (qryConsulta.FieldByName('Preço Venda') As TFloatField).DisplayFormat         := '#,##0.00';
  (qryConsulta.FieldByName('Pr. Custo Colorante') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('Pr. Venda Colorante') As TFloatField).DisplayFormat := '#,##0.00';
end;

procedure TfrmConsultaCadCorImo.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadCorImo.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadCorImo.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
