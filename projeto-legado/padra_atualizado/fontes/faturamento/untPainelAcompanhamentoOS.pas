unit untPainelAcompanhamentoOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Uni, StrUtils;

type
  TfrmPainelAcompanhamentoOS = class(TfrmPai)
    grpPainel: TGridPanel;
    tmrAtuPnl: TTimer;
    pnlQuadro1: TPanel;
    pnlQuadro2: TPanel;
    pnlDescr1: TPanel;
    pnlQtde01: TPanel;
    pnlDescr2: TPanel;
    pnlQtde02: TPanel;
    pnlTopo: TPanel;
    lblDescr1: TLabel;
    lblDescr2: TLabel;
    lblTopo: TLabel;
    pnlQuadro3: TPanel;
    pnlDescr3: TPanel;
    lblDescr3: TLabel;
    pnlQtde03: TPanel;
    pnlQuadro4: TPanel;
    pnlDescr4: TPanel;
    lblDescr4: TLabel;
    pnlQtde04: TPanel;
    pnlQuadro5: TPanel;
    pnlDescr5: TPanel;
    lblDescr5: TLabel;
    pnlQtde05: TPanel;
    pnlQuadro6: TPanel;
    pnlDescr6: TPanel;
    lblDescr6: TLabel;
    pnlQtde06: TPanel;
    pnlQuadro7: TPanel;
    pnlDescr7: TPanel;
    lblDescr7: TLabel;
    pnlQtde07: TPanel;
    pnlQuadro8: TPanel;
    pnlDescr8: TPanel;
    lblDescr8: TLabel;
    pnlQtde08: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrAtuPnlTimer(Sender: TObject);
    procedure pnlQuadro1Resize(Sender: TObject);
    procedure pnlQuadro2Resize(Sender: TObject);
    procedure pnlQuadro3Resize(Sender: TObject);
    procedure pnlQuadro4Resize(Sender: TObject);
    procedure pnlQuadro5Resize(Sender: TObject);
    procedure pnlQuadro6Resize(Sender: TObject);
    procedure pnlQuadro7Resize(Sender: TObject);
    procedure pnlQuadro8Resize(Sender: TObject);
  private
    { Private declarations }
    qryAcoCEQ: TUniQUery;
    procedure pCarregarAcoCEQ;
    procedure pAtualizar;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmPainelAcompanhamentoOS.FormCreate(Sender: TObject);
begin
  inherited;
  qryAcoCEQ := fCriaQuery;
end;

procedure TfrmPainelAcompanhamentoOS.FormDestroy(Sender: TObject);
begin
  inherited;
  tmrAtuPnl.Enabled := False;
  FreeAndNil(qryAcoCEQ);
end;

procedure TfrmPainelAcompanhamentoOS.FormShow(Sender: TObject);
begin
  inherited;
  tmrAtuPnl.Interval := fCfgSis('TPACOS', varInteger) * 1000;
  pCarregarAcoCEQ;
  pAtualizar;
  tmrAtuPnl.Enabled := True;
end;

procedure TfrmPainelAcompanhamentoOS.pAtualizar;
var
  intCont: Integer;
  pnlQuadro,
  pnlQuadroDesc: TPanel;
begin
  qryAcoCEQ.Close;
  qryAcoCEQ.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAcoCEQ.Open;

  intCont := 1;

  while not qryAcoCEQ.Eof do
  begin
    pnlQuadro := fComponentByName(grpPainel, 'pnlQuadro' + intCont.ToString) As TPanel;
    pnlQuadro.Visible := True;

    pnlQuadroDesc := fComponentByName(pnlQuadro, 'pnlDescr' + intCont.ToString) As TPanel;
    TLabel(fComponentByName(pnlQuadroDesc, 'lblDescr' + intCont.ToString)).Caption := fRetornaDescricaoSituacaoOS(qryAcoCEQ.FieldByName('QDR_STATUS').AsString, qryAcoCEQ.FieldByName('QDR_TIPSTA').AsString);
    TPanel(fComponentByName(pnlQuadro, 'pnlQtde0' + intCont.ToString)).Caption := fPadL(qryAcoCEQ.FieldByName('QTDE').AsString, 3, '0');

    intCont := intCont + 1;
    qryAcoCEQ.Next;
  end;
end;

procedure TfrmPainelAcompanhamentoOS.pCarregarAcoCEQ;
var
  strSQL,
  LEmp: String;
  LDias: String;
begin
  LEmp := '';

  if (not fCfgSis('CTDOSA', varBoolean)) then
    LEmp := ' AND EQU_CODEMP = :CODEMP ';

  LDias := ' AND EQU_DTAENT > DATE_SUB(CURDATE(), INTERVAL IFNULL(QDR_QTDIAS, 9999) DAY) ';

  strSQL := '';
  strSQL := strSQL + ' SELECT QDR_QUADRO, QDR_TIPSTA, QDR_STATUS, ';
  strSQL := strSQL + ' (SELECT COUNT(EQU_NUMOSE) ';
  strSQL := strSQL + '  FROM EQUGER ';
  strSQL := strSQL + '  WHERE QDR_STATUS = EQU_FLXFAS';
  strSQL := strSQL + LDias;
  strSQL := strSQL + LEmp;
  strSQL := strSQL + ' ) QTDE ';
  strSQL := strSQL + ' FROM QDRAOS ';
  strSQL := strSQL + ' WHERE IFNULL(QDR_STATUS, "") <> "" ';
  strSQL := strSQL + '   AND QDR_TIPSTA = "F" ';
  strSQL := strSQL + '   AND QDR_CODEMP = :CODEMP ';
  strSQL := strSQL + ' UNION ';
  strSQL := strSQL + ' SELECT QDR_QUADRO, QDR_TIPSTA, QDR_STATUS, ';
  strSQL := strSQL + ' (SELECT COUNT(EQU_NUMOSE) ';
  strSQL := strSQL + '  FROM EQUGER ';
  strSQL := strSQL + '  WHERE QDR_STATUS = EQU_FLXSIT';
  strSQL := strSQL + LDias;
  strSQL := strSQL + LEmp;
  strSQL := strSQL + ' ) QTDE ';
  strSQL := strSQL + ' FROM QDRAOS ';
  strSQL := strSQL + ' WHERE IFNULL(QDR_STATUS, "") <> "" ';
  strSQL := strSQL + '   AND QDR_TIPSTA = "S" ';
  strSQL := strSQL + '   AND QDR_CODEMP = :CODEMP ';
  strSQL := strSQL + ' UNION ';
  strSQL := strSQL + ' SELECT QDR_QUADRO, QDR_TIPSTA, QDR_STATUS, ';
  strSQL := strSQL + ' (SELECT COUNT(EQU_NUMOSE) ';
  strSQL := strSQL + '  FROM EQUGER ';
  strSQL := strSQL + '  WHERE QDR_STATUS = EQU_FLXCOM';
  strSQL := strSQL + LDias;
  strSQL := strSQL + LEmp;
  strSQL := strSQL + ' ) QTDE ';
  strSQL := strSQL + ' FROM QDRAOS ';
  strSQL := strSQL + ' WHERE IFNULL(QDR_STATUS, "") <> "" ';
  strSQL := strSQL + '   AND QDR_TIPSTA = "C" ';
  strSQL := strSQL + '   AND QDR_CODEMP = :CODEMP ';
  strSQL := strSQL + 'ORDER BY 1 ';

  qryAcoCEQ.SQL.Text := strSQL;
end;

procedure TfrmPainelAcompanhamentoOS.pnlQuadro1Resize(Sender: TObject);
begin
  inherited;
  pnlDescr1.Height := Round(pnlQuadro1.Height * 0.40);
end;

procedure TfrmPainelAcompanhamentoOS.pnlQuadro2Resize(Sender: TObject);
begin
  inherited;
  pnlDescr2.Height := Round(pnlQuadro2.Height * 0.40);
end;

procedure TfrmPainelAcompanhamentoOS.pnlQuadro3Resize(Sender: TObject);
begin
  inherited;
  pnlDescr3.Height := Round(pnlQuadro3.Height * 0.40);
end;

procedure TfrmPainelAcompanhamentoOS.pnlQuadro4Resize(Sender: TObject);
begin
  inherited;
  pnlDescr4.Height := Round(pnlQuadro4.Height * 0.40);
end;

procedure TfrmPainelAcompanhamentoOS.pnlQuadro5Resize(Sender: TObject);
begin
  inherited;
  pnlDescr5.Height := Round(pnlQuadro5.Height * 0.40);
end;

procedure TfrmPainelAcompanhamentoOS.pnlQuadro6Resize(Sender: TObject);
begin
  inherited;
  pnlDescr6.Height := Round(pnlQuadro6.Height * 0.40);
end;

procedure TfrmPainelAcompanhamentoOS.pnlQuadro7Resize(Sender: TObject);
begin
  inherited;
  pnlDescr7.Height := Round(pnlQuadro7.Height * 0.40);
end;

procedure TfrmPainelAcompanhamentoOS.pnlQuadro8Resize(Sender: TObject);
begin
  inherited;
  pnlDescr8.Height := Round(pnlQuadro8.Height * 0.40);
end;

procedure TfrmPainelAcompanhamentoOS.tmrAtuPnlTimer(Sender: TObject);
begin
  inherited;
  pAtualizar;
end;

end.
