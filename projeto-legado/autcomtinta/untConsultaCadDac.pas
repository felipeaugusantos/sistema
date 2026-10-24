unit untConsultaCadDac;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadDac = class(TfrmConsultaComp)
    pnlDados: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    dbePreCus: TDBEditFocus;
    dbePreVen: TDBEditFocus;
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
  frmConsultaCadDac: TfrmConsultaCadDac;

implementation

{$R *.dfm}

{ TfrmConsultaCadDac }

procedure TfrmConsultaCadDac.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadDac.pDesabilitaColunas;
begin

  qryConsulta.FieldByName('DAC_PRECUS').Visible := False;
  qryConsulta.FieldByName('DAC_PREVEN').Visible := False;
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;

  (qryConsulta.FieldByName('DAC_PRECUS') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('DAC_PREVEN') As TFloatField).DisplayFormat := '#,##0.00';

end;

procedure TfrmConsultaCadDac.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadDac.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadDac.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
