unit untConsultaCadSta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  EditFocus, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadSta = class(TfrmConsultaComp)
    pnlDados: TPanel;
    lblVenLt: TLabel;
    lblCusLt: TLabel;
    lblCusGl: TLabel;
    lblVenGl: TLabel;
    dbePreVenLt: TDBEditFocus;
    dbePreCusLt: TDBEditFocus;
    dbePreCusGl: TDBEditFocus;
    dbePreVenGl: TDBEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
    procedure pAplicaMascara;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadSta: TfrmConsultaCadSta;

implementation

{$R *.dfm}

procedure TfrmConsultaCadSta.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadSta.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadSta.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadSta.pAplicaMascara;
begin
  (qryConsulta.FieldByName('STA_PREVEN') As TFloatField).DisplayFormat   := '#,##0.00';
  (qryConsulta.FieldByName('STA_PREVEN_GL') As TFloatField).DisplayFormat   := '#,##0.00';
  (qryConsulta.FieldByName('STA_PRECUS') As TFloatField).DisplayFormat   := '#,##0.00';
  (qryConsulta.FieldByName('STA_PRECUS_GL') As TFloatField).DisplayFormat   := '#,##0.00';
end;

procedure TfrmConsultaCadSta.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('STA_PREVEN').Visible := False;
  qryConsulta.FieldByName('STA_PREVEN_GL').Visible := False;
  qryConsulta.FieldByName('STA_PRECUS').Visible := False;
  qryConsulta.FieldByName('STA_PRECUS_GL').Visible := False;

  pAplicaMascara;
end;

procedure TfrmConsultaCadSta.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
  pAplicaMascara;
end;

end.
