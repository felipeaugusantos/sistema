unit untConsultaCadWanGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, Mask, DBCtrls, DBEditFocus, DB,
    Uni, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadWanGeral = class(TfrmConsultaComp)
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    dbeVenLt: TDBEditFocus;
    dbeVenGl: TDBEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadWanGeral: TfrmConsultaCadWanGeral;

implementation

{$R *.dfm}

procedure TfrmConsultaCadWanGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadWanGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadWanGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadWanGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadWanGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('WAN_VENLT').Visible := False;
  qryConsulta.FieldByName('WAN_VENGL').Visible := False;
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;

  (qryConsulta.FieldByName('WAN_VENLT') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('WAN_VENGL') As TFloatField).DisplayFormat := '#,##0.00';
end;

end.
