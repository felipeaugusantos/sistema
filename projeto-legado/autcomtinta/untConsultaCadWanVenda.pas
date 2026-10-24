unit untConsultaCadWanVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, Mask, DBCtrls, DBEditFocus, DB,
    Uni, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadWanVenda = class(TfrmConsultaComp)
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    dbeVenLt: TDBEditFocus;
    dbeVenGl: TDBEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
  frmConsultaCadWanVenda: TfrmConsultaCadWanVenda;

implementation

{$R *.dfm}

{ TfrmConsultaComp1 }

procedure TfrmConsultaCadWanVenda.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadWanVenda.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('WAN_VENLT').Visible := False;
  qryConsulta.FieldByName('WAN_VENGL').Visible := False;
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;

  (qryConsulta.FieldByName('WAN_VENLT') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('WAN_VENGL') As TFloatField).DisplayFormat := '#,##0.00';
end;

procedure TfrmConsultaCadWanVenda.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadWanVenda.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadWanVenda.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadWanVenda.btnExecutaTarefaClick(Sender: TObject);
begin
  inherited;
//  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' ' + VS_strCodEmp + ' TfrmCadEucNovasFormulas', False);
end;

end.
