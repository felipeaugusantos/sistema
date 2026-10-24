unit untConsultaFatItemDev;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Dialogs,
  StdCtrls, untConsultaComp, DB, Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaFatItemDev = class(TfrmConsultaComp)
    pnlDadosItem: TPanel;
    Label3: TLabel;
    dbeQtdIte: TDBEditFocus;
    Label4: TLabel;
    dbeUnitar: TDBEditFocus;
    Label5: TLabel;
    dbeTotIte: TDBEditFocus;
    Label6: TLabel;
    dbeCodGru: TDBEditFocus;
    Label7: TLabel;
    dbeCodIte: TDBEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure lstIndicesClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaFatItemDev: TfrmConsultaFatItemDev;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaFatItemDev.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaFatItemDev.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaFatItemDev.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
  qryConsulta.MoveBy(1);
  qryConsulta.MoveBy(-1);
end;

procedure TfrmConsultaFatItemDev.pDesabilitaColunas;
begin

  If qryConsulta.Active Then
  Begin
    (qryConsulta.FieldByName('DET_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (qryConsulta.FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '#,####0.0000';
    (qryConsulta.FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';

    If Not (qryConsulta.FieldByName('DET_UNIORI').IsNull) Then
    Begin
      (qryConsulta.FieldByName('DET_UNIORI') As TFloatField).DisplayFormat := '#,##0.00';
    End;

    qryConsulta.FieldByName('DET_UNIORI').Visible := False;
    qryConsulta.FieldByName('DET_QTDITE').Visible := False;
    qryConsulta.FieldByName('DET_UNITAR').Visible := False;
    qryConsulta.FieldByName('DET_TOTITE').Visible := False;
    qryConsulta.FieldByName('AUTOINCREM').Visible := False;
    qryConsulta.FieldByName('DET_CODACA').Visible := False;
    qryConsulta.FieldByName('DET_EMPACA').Visible := False;
    qryConsulta.FieldByName('DET_IDEPRO').Visible := False;
    qryConsulta.FieldByName('DET_TABELA').Visible := False;
    qryConsulta.FieldByName('DET_CLAFIS').Visible := False;

  End;

end;

procedure TfrmConsultaFatItemDev.lstIndicesClick(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
