unit untCRMMedias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, EditFocus, Uni,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit;

type
  TTipoResultado = (trContagem, trValor, trValorDesconto);

  TfrmCrmMedias = class(TfrmPai)
    pnlInfCliente: TPanel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    lblCliCpfCnpj: TLabel;
    edtCliCod: TEditFocus;
    edtCliNom: TEditFocus;
    edtCliCid: TEditFocus;
    edtCliCpfCnpj: TEditFocus;
    pnlInfRede: TPanel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label11: TLabel;
    edtRedCod: TEditFocus;
    edtRedDes: TEditFocus;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lblTxConvOrPd: TLabel;
    lblTicketMedioMensal: TLabel;
    lblMediaVendaU3M: TLabel;
    lblVendasNesteMes: TLabel;
    lblMediaDescontoMes: TLabel;
    lblMediaDescontoU3M: TLabel;
    lblFiltroDias: TLabel;
    spnFiltroDias: TcxSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure spnFiltroDiasPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    FCodCliente: String;
    FCodRed: String;
    FCliConsumidor: Boolean;

    FstrClaVen: String;
    FstrClaDev: String;
    FstrClaBri: String;

    FQtdOrcamento: Integer;
    FQtdVenda: Integer;
    FQtdVendaSemDev: Integer;

    FValorVendaLiq: Double;
    FValorVendaBruMes: Double;
    FValorVendaLiqMes: Double;
    FValorDescontoMes: Double;
    FQtdVendaMes: Integer;
    FPeDescontoMes: Double;

    FValorVendaLiqU3M: Double;
    FQtdVendaU3M: Integer;

    FTxConvOrPd: Double;
    FTicketMedioMensal: Double;
    FVlrMediaVendaU3M: Double;
    FVlrMediaDescontoMes: Double;
    FVlrMediaDescontoU3M: Double;
    FValorDescontoU3M: Double;
    FValorVendaBruU3M: Double;
    FPeDescontoU3M: Double;


    procedure pCarregaDadosCliente;
    procedure pCarregaDadosRedeLoja;
    procedure pCalcularMedia;
    procedure pExibirDados;
    procedure pGetDadosOrcamento;
    procedure pGetDadosVenda;
    procedure pGetDadosAtual;
    procedure pGetDadosUltimos3Meses;
    procedure pCarregarDados;

    function fGetSqlOrcamentos(ATipo: TTipoResultado): String;
    function fGetSqlVendas: String;
    function fRetornaCliRedeLoja: String;
    procedure pSetCodCliente(const Value: String);

  public
    { Public declarations }
    property CodCliente: String read FCodCliente write pSetCodCliente;
    property CliConsumidor: Boolean read FCliConsumidor write FCliConsumidor;
  end;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica, DateUtils, untGravando;

{$R *.dfm}

procedure TfrmCrmMedias.pCarregaDadosCliente;
var
  qryCliente: TUniQuery;
begin
  qryCliente := fCriaQuery;
  try
    qryCliente.SQL.Add('SELECT CLI_CODCLI, CLI_NOMCLI, CLI_CGCCPF, CLI_C_G_C_, CID_NOMCID, CID_ESTADO');
    qryCliente.SQL.Add('FROM CADCLI');
    qryCliente.SQL.Add('LEFT JOIN CADCID ON CLI_CODCID = CID_CODCID');
    qryCliente.SQL.Add('WHERE CLI_CODCLI IN (' + CodCliente + ')');
    qryCliente.Open;

    pnlInfCliente.Visible := True;
    edtCliCod.Text        := qryCliente.FieldByName('CLI_CODCLI').AsString;
    edtCliNom.Text        := qryCliente.FieldByName('CLI_NOMCLI').AsString;
    edtCliCpfCnpj.Text    := fFormataCpfCgc(qryCliente.FieldByName('CLI_C_G_C_').AsString, fSetaPais);
    lblCliCpfCnpj.Caption := IIF(qryCliente.FieldByName('CLI_CGCCPF').AsString = '2', 'CPF :', 'CNPJ :' );
    edtCliCid.Text        := qryCliente.FieldByName('CID_NOMCID').AsString + ' - ' + qryCliente.FieldByName('CID_ESTADO').AsString;
  finally
    qryCliente.Free;
  end;
end;

procedure TfrmCrmMedias.pCarregaDadosRedeLoja;
var
  LQryConsulta: TUniQuery;
begin
  LQryConsulta := fCriaQuery;
  try
    LQryConsulta.SQL.Add('SELECT RED_CODRED, RED_DESRED');
    LQryConsulta.SQL.Add('FROM CADRED');
    LQryConsulta.SQL.Add('WHERE RED_CODRED = ' + FCodRed);
    LQryConsulta.Open;

    pnlInfRede.Visible := True;
    edtRedCod.Text     := LQryConsulta.FieldByName('RED_CODRED').AsString;
    edtRedDes.Text     := LQryConsulta.FieldByName('RED_DESRED').AsString;
  finally
    LQryConsulta.Free;
  end;
end;

procedure TfrmCrmMedias.pCalcularMedia;
begin
  FValorDescontoMes  := FValorVendaBruMes - FValorVendaLiqMes;
  FValorDescontoU3M  := FValorVendaBruU3M - FValorVendaLiqU3M;
  FPeDescontoMes := 0;
  FPeDescontoU3M := 0;
  FVlrMediaDescontoMes := 0;
  FVlrMediaDescontoU3M := 0;

  If FQtdOrcamento > 0 Then
    FTxConvOrPd := (FQtdVendaSemDev / FQtdOrcamento * 100);

  If FQtdVenda > 0 Then
    FTicketMedioMensal := (FValorVendaLiq / FQtdVenda);

  If FQtdVendaU3M > 0 Then
    FVlrMediaVendaU3M := (FValorVendaLiqU3M / FQtdVendaU3M);

  If (FQtdVendaMes > 0) and (FValorVendaBruMes > 0) Then
  Begin
    FVlrMediaDescontoMes := (FValorDescontoMes / FQtdVendaMes);
    FPeDescontoMes := (FValorDescontoMes / FValorVendaBruMes) * 100;
    FPeDescontoMes := FPeDescontoMes / FQtdVendaMes;
  End;

  If (FQtdVendaU3M > 0)  and (FValorVendaBruU3M > 0)  Then
  Begin
    FVlrMediaDescontoU3M := (FValorDescontoU3M / FQtdVendaU3M);
    FPeDescontoU3M := (FValorDescontoU3M / FValorVendaBruU3M) * 100;
    FPeDescontoU3M := FPeDescontoU3M / FQtdVendaU3M;
  End;
end;

procedure TfrmCrmMedias.pExibirDados;
begin
  lblTxConvOrPd.Caption := FormatFloat('#,##0.00 %', FTxConvOrPd);
  lblTicketMedioMensal.Caption := FormatFloat('R$ #,##0.00', FTicketMedioMensal);
  lblVendasNesteMes.Caption := FormatFloat('R$ #,##0.00', FValorVendaLiqMes);
  lblMediaVendaU3M.Caption := FormatFloat('R$ #,##0.00', FVlrMediaVendaU3M);
  lblMediaDescontoMes.Caption := FormatFloat('#,##0.00 %', FPeDescontoMes);
  lblMediaDescontoU3M.Caption := FormatFloat('#,##0.00 %', FPeDescontoU3M);
end;

procedure TfrmCrmMedias.pCarregarDados;
begin
  pGetDadosOrcamento;
  pGetDadosVenda;
  pCalcularMedia;
  pExibirDados;
end;

procedure TfrmCrmMedias.FormShow(Sender: TObject);
begin
  inherited;
  FstrClaVen := fTransform(fCfgSis('CLAVEN'), 4);
  FstrClaDev := fTransform(fCfgSis('CLADEV'), 4);
  FstrClaBri := '5910_6910_';

  if fEmptyStr(FCodRed) then
  begin
    pCarregaDadosCliente;
    Self.Height := Self.Height - pnlInfRede.Height;
  end
  else
  begin
    pCarregaDadosRedeLoja;
    Self.Height := Self.Height - pnlInfCliente.Height;
  end;

  spnFiltroDias.Visible := FCliConsumidor;
  lblFiltroDias.Visible := FCliConsumidor;

  TfrmGravando.fExecutarModal(pCarregarDados, 'Por favor, aguarde...', '');

end;

function TfrmCrmMedias.fGetSqlOrcamentos(ATipo: TTipoResultado): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Case ATipo Of
    trValor   : Result := Result + '  SUM(FGO_TOTPRO + FGO_TOTSER - FGO_DESESP) AS VALOR ';
    trContagem: Result := Result + '  COUNT(0)  AS VALOR ';
  End;
  Result := Result + 'FROM FATGOR G ';
  Result := Result + 'INNER JOIN EXTGOR ';
  Result := Result + '  ON FGO_SEQFGO = G.AUTOINCREM ';
  Result := Result + 'WHERE (FGO_TEMBRI = "S" OR FGO_VLRCON <> 0) ';
  Result := Result + '  AND ((FGO_ESPDOC = "OR" AND IFNULL(FGO_TIPFAT, "") <> "PD") OR FGO_ESPDOC = "PD") ';
  Result := Result + '  AND FGO_CODCLI IN (' + CodCliente + ')';
end;

procedure TfrmCrmMedias.pGetDadosOrcamento;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(fGetSqlOrcamentos(trContagem));
    qryConsulta.Open;

    FQtdOrcamento := qryConsulta.Fields[0].AsInteger;
  finally
    qryConsulta.Free;
  end;
end;

function TfrmCrmMedias.fRetornaCliRedeLoja: String;
var
  LQryConsulta: TUniQuery;
begin
  Result := '';
  LQryConsulta := fCriaQuery;
  try
    LQryConsulta.SQL.Add('SELECT CLI_CODCLI');
    LQryConsulta.SQL.Add('FROM CADCLI');
    LQryConsulta.SQL.Add('WHERE CLI_CODRED = :CODRED');
    LQryConsulta.ParamByName('CODRED').AsString := FCodRed;
    LQryConsulta.Open;
    while not LQryConsulta.Eof do
    begin
      Result := Result + QuotedStr(LQryConsulta.FieldByName('CLI_CODCLI').AsString) + ',';

      LQryConsulta.Next;
    end;

    Result := Copy(Result, 1, Length(Result) - 1);
  finally
    LQryConsulta.Free;
  end;
end;

procedure TfrmCrmMedias.pSetCodCliente(const Value: String);
begin
  FCodRed := fCampoTabela('CLI_CODRED', 'CADCLI', ['CLI_CODCLI'], [Value]);
  if fEmptyStr(FCodRed) then
    FCodCliente := Value.QuotedString
  else
    FCodCliente := fRetornaCliRedeLoja;
end;

procedure TfrmCrmMedias.spnFiltroDiasPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCarregarDados, 'Por favor, aguarde...', '');
end;

function TfrmCrmMedias.fGetSqlVendas: String;
begin
  Result := '';
  Result := Result +'SELECT ';

  If spnFiltroDias.Visible Then
  Begin
    Result := Result + ' COUNT(DISTINCT ';
    Result := Result + '        (CASE WHEN DET_DTAENT BETWEEN :DTAVENINI AND :DTAVENFIM ';
    Result := Result + '              THEN G.AUTOINCREM END ) ) AS QTD_VENDAS, ';

    Result := Result + ' COUNT( DISTINCT ';
    Result := Result + '        (CASE WHEN LEFT(DET_CLAFIS,1) > 5 AND ';
    Result := Result + '              DET_DTAENT BETWEEN :DTAVENINI AND :DTAVENFIM  ';
    Result := Result + '              THEN G.AUTOINCREM  ';
    Result := Result + '         END )        ';
    Result := Result + ' ) AS QTD_VENDAS_SEM_DEV, ';
  End
  Else
  Begin
    Result := Result + ' COUNT(DISTINCT G.AUTOINCREM) AS QTD_VENDAS, ';

    Result := Result + ' COUNT( DISTINCT ';
    Result := Result + '        (CASE WHEN LEFT(DET_CLAFIS,1) < 5 THEN 0  ';
    Result := Result + '            ELSE G.AUTOINCREM ';
    Result := Result + '         END )        ';
    Result := Result + ' ) AS QTD_VENDAS_SEM_DEV, ';
  End;

  Result := Result + ' COUNT( DISTINCT ';
  Result := Result + '        (CASE WHEN DET_DTAENT BETWEEN :DTAINI AND :DTAFIM THEN G.AUTOINCREM ';
  Result := Result + '         END )        ';
  Result := Result + ' ) AS QTD_VENDAS_MES, ';

  Result := Result + ' SUM( ';
  Result := Result + '     IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + QuotedStr(FstrClaBri) + '), 0,';
  Result := Result + '       IF(LEFT(DET_CLAFIS,1) < 5,';
  Result := Result + '         -(DET_TOTITE - DET_DESESP - DET_DESCFF), ';
  Result := Result + '           DET_TOTITE - DET_DESESP - DET_DESCFF))   ';
  Result := Result + '    ) AS VLR_VENDAS_LIQ, ';

  Result := Result + ' SUM( ';
  Result := Result + '       (CASE WHEN DET_DTAENT BETWEEN :DTAINI AND :DTAFIM THEN ';
  Result := Result + '         IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + QuotedStr(FstrClaBri) + '), 0,';
  Result := Result + '           IF(LEFT(DET_CLAFIS,1) < 5,';
  Result := Result + '             -(DET_TOTITE - DET_DESESP - DET_DESCFF), ';
  Result := Result + '               DET_TOTITE - DET_DESESP - DET_DESCFF))   ';
  Result := Result + '        ELSE 0 END)  ';
  Result := Result + '    ) AS VLR_VENDAS_LIQ_MES, ';

  Result := Result + ' SUM( ';
  Result := Result + '       (CASE WHEN DET_DTAENT BETWEEN :DTAINI AND :DTAFIM THEN ';
  Result := Result + '          IF(LEFT(DET_CLAFIS,1) < 5,  ';
  Result := Result + '             - (IF(IFNULL(DET_UNIORI, 0) = 0, DET_UNITAR, DET_UNIORI) * DET_QTDITE), ';
  Result := Result + '               (IF(IFNULL(DET_UNIORI, 0) = 0, DET_UNITAR, DET_UNIORI) * DET_QTDITE)) ';
  Result := Result + '        ELSE 0 END)  ';
  Result := Result + '    ) AS VLR_VENDAS_BRU_MES ';

  Result := Result +'FROM  MOVDET D      ';
  Result := Result +'  INNER JOIN MOVGER G ON D.DET_SEQGER = G.AUTOINCREM ';
  Result := Result +'  LEFT  JOIN MOVICD   ON   ICD_SEQGER = D.AUTOINCREM AND D.DET_VALRET = 0 ';
  Result := Result +' WHERE G.GER_CODCLI IN (' + CodCliente + ') ';
  Result := Result +'  AND DET_PROEMB <> "S" ';
  Result := Result +'  AND DET_TIP_FC = "C"  ';
  Result := Result +'  AND ((LOCATE(DET_CLAFIS, ' + QuotedStr(FstrClaVen) + ') > 0) OR (LOCATE(DET_CLAFIS, ' + QuotedStr(FstrClaDev) + ') > 0) ';

  If fCfgSis('ENTBRF') = 'S' Then
    Result := Result +' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + QuotedStr(FstrClaBri) + ')) '
  Else
    Result := Result +') ';
  Result := Result +'  AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';


  Result := Result +' AND G.GER_NUMDOC <> "000000000013" ';
  Result := Result +' AND G.GER_NUMDOC <> "000000026082" ';


end;

procedure TfrmCrmMedias.pGetDadosAtual;
var
  qryConsulta: TUniQuery;
  dtaIni, dtaFim: TDateTime;
begin
  dtaIni := StartOfTheMonth(VS_Date);
  dtaFim := VS_Date;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(fGetSqlVendas);
    qryConsulta.ParamByName('DTAINI').AsDateTime := dtaIni;
    qryConsulta.ParamByName('DTAFIM').AsDateTime := dtaFim;

    If spnFiltroDias.Visible Then
    Begin
      qryConsulta.ParamByName('DTAVENINI').AsDateTime := IncDay(VS_Date, -spnFiltroDias.Value);
      qryConsulta.ParamByName('DTAVENFIM').AsDateTime := VS_Date;
    End;

    qryConsulta.Open;

    FQtdVenda          := qryConsulta.FieldByName('QTD_VENDAS').AsInteger;
    FQtdVendaSemDev    := qryConsulta.FieldByName('QTD_VENDAS_SEM_DEV').AsInteger;
    FQtdVendaMes       := qryConsulta.FieldByName('QTD_VENDAS_MES').AsInteger;

    FValorVendaLiq     := qryConsulta.FieldByName('VLR_VENDAS_LIQ').AsFloat;
    FValorVendaLiqMes  := qryConsulta.FieldByName('VLR_VENDAS_LIQ_MES').AsFloat;
    FValorVendaBruMes  := qryConsulta.FieldByName('VLR_VENDAS_BRU_MES').AsFloat;

  Finally
    qryConsulta.Free;
  End;
end;

procedure TfrmCrmMedias.pGetDadosUltimos3Meses;
var
  qryConsulta: TUniQuery;
  dtaIni, dtaFim: TDateTime;
begin
  dtaIni := IncMonth(VS_Date, -3);
  dtaFim := VS_Date;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(fGetSqlVendas);
    qryConsulta.ParamByName('DTAINI').AsDateTime := dtaIni;
    qryConsulta.ParamByName('DTAFIM').AsDateTime := dtaFim;
    qryConsulta.Open;

    FQtdVendaU3M := qryConsulta.FieldByName('QTD_VENDAS_MES').AsInteger;
    FValorVendaLiqU3M  := qryConsulta.FieldByName('VLR_VENDAS_LIQ_MES').AsFloat;
    FValorVendaBruU3M  := qryConsulta.FieldByName('VLR_VENDAS_BRU_MES').AsFloat;

  Finally
    qryConsulta.Free;
  End;
end;

procedure TfrmCrmMedias.pGetDadosVenda;
begin
  pGetDadosAtual;
  pGetDadosUltimos3Meses;
end;

end.
