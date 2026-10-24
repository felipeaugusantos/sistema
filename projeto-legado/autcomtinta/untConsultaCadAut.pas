unit untConsultaCadAut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, Mask,
  DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadAut = class(TfrmConsultaComp)
    Panel2: TPanel;
    dbeVenLt: TDBEditFocus;
    Label4: TLabel;
    dbeCusLt: TDBEditFocus;
    Label3: TLabel;
    dbeVenGl: TDBEditFocus;
    Label5: TLabel;
    dbeCusGl: TDBEditFocus;
    Label6: TLabel;
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
  frmConsultaCadAut: TfrmConsultaCadAut;

implementation

{$R *.dfm}

{ TfrmConsultaCadAut }

procedure TfrmConsultaCadAut.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadAut.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUT_VENLT').Visible := False;
  qryConsulta.FieldByName('AUT_CUSLT').Visible := False;
  qryConsulta.FieldByName('AUT_VENGL').Visible := False;
  qryConsulta.FieldByName('AUT_CUSGL').Visible := False;
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;

  (qryConsulta.FieldByName('AUT_VENLT') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('AUT_CUSLT') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('AUT_VENGL') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('AUT_CUSGL') As TFloatField).DisplayFormat := '#,##0.00';
end;

procedure TfrmConsultaCadAut.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadAut.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadAut.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
