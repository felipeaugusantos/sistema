unit untConsultaCadAca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  untConstantes, BitBtnLockedIncrem, StrUtils, MemDS,
  DBAccess;

type
  TfrmConsultaCadAca = class(TfrmConsultaComp)
    Shape: TShape;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
    strOpcDoc: String;
    opcConsulta: TOpcConsultaProdutoAcabado;
  end;

var
  frmConsultaCadAca: TfrmConsultaCadAca;

implementation

uses untConsultaCadAcaLojas, untConsulta,untFuncoesSimples;

{$R *.dfm}

{ TfrmConsultaCadAca }

procedure TfrmConsultaCadAca.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadAca.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('ACA_CODEMP').Visible := False;
  TFloatField(qryConsulta.FieldByName('Saldo')).DisplayFormat := '#,###0.000';
  TFloatField(qryConsulta.FieldByName('Preço de Venda')).DisplayFormat := '#,##0.00';
end;

procedure TfrmConsultaCadAca.FormCreate(Sender: TObject);
begin
  inherited;

  opcConsulta := ocaPadrao; 
end;

procedure TfrmConsultaCadAca.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
  Self.WindowState := wsNormal;
  Self.WindowState := wsMaximized;  
end;

procedure TfrmConsultaCadAca.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadAca.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadAca.btnExecutaTarefaClick(Sender: TObject);
begin
  inherited;
  If dbgConsulta.DataSource.DataSet.IsEmpty Then
    Exit;

  Application.CreateForm(TfrmConsultaCadAcaLojas, frmConsultaCadAcaLojas);
  frmConsultaCadAcaLojas.strCodAca := dbgConsulta.DataSource.DataSet.FieldByName('Código').AsString;
  frmConsultaCadAcaLojas.strCodEmp := dbgConsulta.DataSource.DataSet.FieldByName('ACA_CODEMP').AsString;
  frmConsultaCadAcaLojas.ShowModal;
  FreeAndNil(frmConsultaCadAcaLojas);
end;

procedure TfrmConsultaCadAca.btnConfirmaClick(Sender: TObject);
begin
  If (opcConsulta <> ocaTodos) And
     (qryConsulta.FieldByName('Saldo').AsFloat <= 0) And (not MatchText(strOpcDoc, ['TR', 'OE'])) Then
    fMensagem('', 'Produto sem saldo!', ['&Ok'])
  Else
    inherited;
end;

procedure TfrmConsultaCadAca.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With dbgConsulta.Canvas Do
  Begin
    If qryConsulta.IsEmpty Then
      Exit;

     If qryConsulta.FieldByName('Saldo').AsFloat < 0 Then
       Brush.Color := clRed;
  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

end.
