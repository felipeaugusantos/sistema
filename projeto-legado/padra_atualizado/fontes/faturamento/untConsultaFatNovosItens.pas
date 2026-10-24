unit untConsultaFatNovosItens;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Dialogs,
  StdCtrls, untConsultaComp, DB, Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaFatNovosItens = class(TfrmConsultaComp)
    pnlDadosItem: TPanel;
    Label3: TLabel;
    dbePreVen: TDBEditFocus;
    Label4: TLabel;
    dbeSaldos: TDBEditFocus;
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
  frmConsultaFatNovosItens: TfrmConsultaFatNovosItens;

implementation

{$R *.dfm}

{ TfrmConsultaFatNovosItens }

procedure TfrmConsultaFatNovosItens.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;

end;

procedure TfrmConsultaFatNovosItens.pDesabilitaColunas;
begin

  If qryConsulta.Active Then
  Begin
    (qryConsulta.FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,###0.000';
    (qryConsulta.FieldByName('ITE_PREVE1') As TFloatField).DisplayFormat := '#,###0.000';
    (qryConsulta.FieldByName('ITE_PREVE2') As TFloatField).DisplayFormat := '#,###0.000';
    (qryConsulta.FieldByName('ITE_PREVE3') As TFloatField).DisplayFormat := '#,###0.000';
    (qryConsulta.FieldByName('ITE_PREVE4') As TFloatField).DisplayFormat := '#,###0.000';
    (qryConsulta.FieldByName('ITE_PREVE5') As TFloatField).DisplayFormat := '#,###0.000';
    (qryConsulta.FieldByName('ITE_PREVE6') As TFloatField).DisplayFormat := '#,###0.000';
    (qryConsulta.FieldByName('ITE_PREVE7') As TFloatField).DisplayFormat := '#,###0.000';

    qryConsulta.FieldByName('ITE_SALDOS').Visible := False;
    qryConsulta.FieldByName('ITE_PREVE1').Visible := False;
    qryConsulta.FieldByName('ITE_PREVE2').Visible := False;
    qryConsulta.FieldByName('ITE_PREVE3').Visible := False;
    qryConsulta.FieldByName('ITE_PREVE4').Visible := False;
    qryConsulta.FieldByName('ITE_PREVE5').Visible := False;
    qryConsulta.FieldByName('ITE_PREVE6').Visible := False;
    qryConsulta.FieldByName('ITE_PREVE7').Visible := False;
  End;

end;

procedure TfrmConsultaFatNovosItens.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;

end;

procedure TfrmConsultaFatNovosItens.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaFatNovosItens.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
