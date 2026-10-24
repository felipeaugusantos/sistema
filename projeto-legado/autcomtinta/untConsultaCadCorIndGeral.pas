unit untConsultaCadCorIndGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, Mask,
  DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadCorIndGeral = class(TfrmConsultaComp)
    Panel2: TPanel;
    Label4: TLabel;
    dbePreVen: TDBEditFocus;
    Label5: TLabel;
    dbeColVen: TDBEditFocus;
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
  frmConsultaCadCorIndGeral: TfrmConsultaCadCorIndGeral;

implementation

{$R *.dfm}

{ TfrmConsultaCadCorIndGeral }

procedure TfrmConsultaCadCorIndGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadCorIndGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('COR_PREVEN').Visible := False;
  qryConsulta.FieldByName('COR_COLVEN').Visible := False;
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;

  (qryConsulta.FieldByName('COR_PREVEN') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('COR_COLVEN') As TFloatField).DisplayFormat := '#,##0.00';
end;

procedure TfrmConsultaCadCorIndGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadCorIndGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadCorIndGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
