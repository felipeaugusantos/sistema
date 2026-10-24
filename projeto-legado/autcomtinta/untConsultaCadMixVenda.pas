unit untConsultaCadMixVenda;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadMixVenda = class(TfrmConsultaComp)
    pnlDados: TPanel;
    lblVenConLt: TLabel;
    lblVenConGl: TLabel;
    lblVenDilLt: TLabel;
    lblVenDilGl: TLabel;
    edtVenConLt: TEditFocus;
    edtVenConGl: TEditFocus;
    edtVenDilLt: TEditFocus;
    edtVenDilGl: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
    procedure pAplicaMascara;
    procedure pCalculaDados;

    procedure pAtualizaDados(Data: TDataSet);
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadMixVenda: TfrmConsultaCadMixVenda;

implementation

uses untConsulta, untFuncoes, untFuncoesSimples, untTintaMaquina,untIConfTinta;

{$R *.dfm}

procedure TfrmConsultaCadMixVenda.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadMixVenda.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
  pCalculaDados;
end;

procedure TfrmConsultaCadMixVenda.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('MIX_PRECO1').Visible   := False;
  qryConsulta.FieldByName('MIX_PRECO2').Visible   := False;
  qryConsulta.FieldByName('MIX_PRECO3').Visible   := False;
  qryConsulta.FieldByName('MIX_PRECO4').Visible   := False;
  qryConsulta.FieldByName('MIX_PRECO1_4').Visible := False;
  qryConsulta.FieldByName('MIX_PRECO2_4').Visible := False;
  qryConsulta.FieldByName('MIX_PRECO3_4').Visible := False;
  qryConsulta.FieldByName('MIX_PRECO4_4').Visible := False;

  pAplicaMascara;
end;

procedure TfrmConsultaCadMixVenda.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadMixVenda.pAplicaMascara;
begin
  (qryConsulta.FieldByName('MIX_PRECO1') As TFloatField).DisplayFormat   := '#,##0.00';
  (qryConsulta.FieldByName('MIX_PRECO2') As TFloatField).DisplayFormat   := '#,##0.00';
  (qryConsulta.FieldByName('MIX_PRECO3') As TFloatField).DisplayFormat   := '#,##0.00';
  (qryConsulta.FieldByName('MIX_PRECO4') As TFloatField).DisplayFormat   := '#,##0.00';
  (qryConsulta.FieldByName('MIX_PRECO1_4') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('MIX_PRECO2_4') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('MIX_PRECO3_4') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('MIX_PRECO4_4') As TFloatField).DisplayFormat := '#,##0.00';

  lblVenDilLt.Caption := 'Pr. Venda Dil. Lt. ';
  lblVenDilGl.Caption := 'Pr. Venda Dil. Gl. ';


  If (Pos('POLIURETANO', qryConsulta.FieldByName('Referencia').AsString) <= 0) Then
  Begin
    lblVenDilLt.Caption := lblVenDilLt.Caption + '0,900:';
    lblVenDilGl.Caption := lblVenDilGl.Caption + '3,600:';
  End
  Else
  Begin
    lblVenDilLt.Caption := lblVenDilLt.Caption + '0,660:';
    lblVenDilGl.Caption := lblVenDilGl.Caption + '2,640:';
  End;
end;

procedure TfrmConsultaCadMixVenda.pAtualizaDados(Data: TDataSet);
begin
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadMixVenda.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaCadMixVenda.pCalculaDados;
  Var
    fltValor: Double;
    fltValor3: Double;
    fltValor3_4: Double;
    conf : IConfTinta;
begin

  With qryConsulta Do
  Begin
    conf := fGetConfTinta('LAZ');
    {*****************************************}
    {* PRIMEIRA COLUNA                       *}
    {**************************************MV*}
    fltValor         := FieldByName('MIX_PRECO1').AsFloat + IIF(FieldByName('MIX_PRECO1').AsFloat > 0.0, conf.fGetDouble('GALLAZ'), 0.0);
    edtVenConLt.Text := FloatToStrF(fltValor, ffFixed, 12, 4);

    fltValor         := FieldByName('MIX_PRECO1_4').AsFloat + IIF(FieldByName('MIX_PRECO1').AsFloat > 0.0, conf.fGetDouble('GALLAZ'), 0.0);
    edtVenConGl.Text := FloatToStrF(fltValor, ffFixed, 12, 4);

    {*****************************************}
    {* SEGUNDA COLUNA                        *}
    {**************************************MV*}
{    fltValor         := FieldByName('MIX_PRECO3').AsFloat + IIF(FieldByName('MIX_PRECO3').AsFloat > 0.0, conf.fGetDouble('GALLAZ'), 0.0);
    edtVenDilLt.Text := FloatToStrF(fltValor, ffFixed, 12, 4);

    fltValor         := FieldByName('MIX_PRECO3_4').AsFloat + IIF(FieldByName('MIX_PRECO3').AsFloat > 0.0, conf.fGetDouble('GALLAZ'), 0.0);
    edtVenDilGl.Text := FloatToStrF(fltValor, ffFixed, 12, 4);}

    fltValor3   := FieldByName('MIX_PRECO3').AsFloat;
    fltValor3_4 := FieldByName('MIX_PRECO3_4').AsFloat;

    If (Pos('POLIURETANO', FieldByName('Referencia').AsString) > 0) Then
    Begin
      fltValor3   := (fltValor3   / 0.900) * 0.660;
      fltValor3_4 := (fltValor3_4 / 0.900) * 0.660;
    End;

    {*******************************************}
    {* SOMA O VALOR DA EMBALAGEM                *}
    {****************************************MV*}
    fltValor3   := fltValor3   + IIF(FieldByName('MIX_PRECO3').AsFloat > 0.0, conf.fGetDouble('EMBLAZ'), 0.0);
    fltValor3_4 := fltValor3_4 + IIF(FieldByName('MIX_PRECO3').AsFloat > 0.0, conf.fGetDouble('GALLAZ'), 0.0);

    edtVenDilLt.Text := FloatToStrF(fltValor3  , ffFixed, 12, 2);
    edtVenDilGl.Text := FloatToStrF(fltValor3_4, ffFixed, 12, 2);

  End;

end;

procedure TfrmConsultaCadMixVenda.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadMixVenda.btnExecutaTarefaClick(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadMixNovasFormulas', False);
end;

end.
