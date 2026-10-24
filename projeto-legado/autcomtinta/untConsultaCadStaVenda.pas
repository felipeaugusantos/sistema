unit untConsultaCadStaVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  EditFocus, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadStaVenda = class(TfrmConsultaComp)
    pnlDados: TPanel;
    lblVenLt: TLabel;
    lblVenGl: TLabel;
    dbePreVenLt: TDBEditFocus;
    dbePreVenGl: TDBEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
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
  frmConsultaCadStaVenda: TfrmConsultaCadStaVenda;

implementation

uses untFuncoes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaCadStaVenda.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadStaVenda.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadStaVenda.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadStaVenda.pAplicaMascara;
begin
  (qryConsulta.FieldByName('STA_PREVEN') As TFloatField).DisplayFormat   := '#,##0.00';
  (qryConsulta.FieldByName('STA_PREVEN_GL') As TFloatField).DisplayFormat   := '#,##0.00';
end;

procedure TfrmConsultaCadStaVenda.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('STA_PREVEN').Visible := False;
  qryConsulta.FieldByName('STA_PREVEN_GL').Visible := False;

  pAplicaMascara;
end;

procedure TfrmConsultaCadStaVenda.pAtuIndice(intIndice: Integer);
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

procedure TfrmConsultaCadStaVenda.btnExecutaTarefaClick(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadStaNovasFormulas', False);
end;

end.
