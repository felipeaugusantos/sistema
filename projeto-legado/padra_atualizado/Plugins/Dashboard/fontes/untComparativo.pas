unit untComparativo;

interface

uses
  System.SysUtils, System.StrUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs,
  FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, FMXTee.Engine, FMXTee.Series,
  FMX.Ani, FMXTee.Procs, FMXTee.Chart, FMX.Layouts, untFrameBase, System.DateUtils,
  System.Math;

type
  TfraComparativo = class(TfraBaseFrame)
    Chart1: TChart;
    fundoAnimacao: TRectangle;
    FloatAnimation20: TFloatAnimation;
    serAnoAnterior: TLineSeries;
    serAnoAtual: TLineSeries;
    lblAnoAntTotal: TLabel;
    lblAnoAntDesc: TLabel;
    lblAnoAtuTotal: TLabel;
    lblAnoAtuDesc: TLabel;
    lblTituloValorVendas: TLabel;
    recQuantidadeTickets: TRectangle;
    Chart2: TChart;
    Rectangle3: TRectangle;
    FloatAnimation1: TFloatAnimation;
    serTicketAnoAnt: TLineSeries;
    serTicketAnoAtu: TLineSeries;
    Layout7: TLayout;
    lblLegAnoAnt2: TLabel;
    RoundRect3: TRoundRect;
    lblLegAnoAtu2: TLabel;
    RoundRect4: TRoundRect;
    lblAnoAntTickets: TLabel;
    lblAnoAntTicketsDesc: TLabel;
    lblAnoAtuTickets: TLabel;
    lblAnoAtuTicketsDesc: TLabel;
    lblTituloQuantidadeVendas: TLabel;
    recValorTickets: TCalloutRectangle;
    lblValorTickets: TLabel;
    cirCorTickets: TCircle;
    lblDataTickets: TLabel;
    anmValorTickets: TFloatAnimation;
    recValorVendas: TRectangle;
    FlowLayout3: TFlowLayout;
    FlowLayout4: TFlowLayout;
    calValorVendas: TCalloutRectangle;
    lblValorVendas: TLabel;
    cirCorVendas: TCircle;
    lblDataVendas: TLabel;
    anmValorVendas: TFloatAnimation;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    FlowLayout5: TFlowLayout;
    lblHojeAnoAntTickets: TLabel;
    lblHojeAnoAntTicketsDesc: TLabel;
    lblHojeAnoAntTotal: TLabel;
    lblHojeAnoAntTotalDesc: TLabel;
    lblDiferencaValor: TLabel;
    Label4: TLabel;
    lblDiferencaTickets: TLabel;
    Label8: TLabel;
    lblDiferencaPercent: TLabel;
    FlowLayoutBreak2: TFlowLayoutBreak;
    recParticipacaoVendasPessoa: TRectangle;
    Label1: TLabel;
    Rectangle13: TRectangle;
    FlowLayout7: TFlowLayout;
    FlowLayout8: TFlowLayout;
    Label10: TLabel;
    RoundRect14: TRoundRect;
    Label11: TLabel;
    RoundRect13: TRoundRect;
    Label12: TLabel;
    RoundRect15: TRoundRect;
    Label16: TLabel;
    RoundRect16: TRoundRect;
    layAnterior: TLayout;
    lblParticipacaoPessoaAnoAnterior: TLabel;
    recPartClienteAnt: TRectangle;
    lineParCliAnt_5: TLine;
    lblParCliAnt_5: TLabel;
    lblParCliAnt_4: TLabel;
    lineParCliAnt_4: TLine;
    lblParCliAnt_3: TLabel;
    lineParCliAnt_3: TLine;
    lblParCliAnt_2: TLabel;
    lineParCliAnt_2: TLine;
    lblParCliAnt_1: TLabel;
    lineParCliAnt_1: TLine;
    recPartAntPFisica: TRectangle;
    anmPartAntPFisicaHeight: TFloatAnimation;
    anmPartAntPFisicaTop: TFloatAnimation;
    recPartAntIndustria: TRectangle;
    anmPartAntIndustriaHeight: TFloatAnimation;
    anmPartAntIndustriaTop: TFloatAnimation;
    lblParAntIndustria: TLabel;
    lblParAntPFisica: TLabel;
    recPartAntAutonomo: TRectangle;
    anmPartAntAutonomoHeight: TFloatAnimation;
    anmPartAntAutonomoTop: TFloatAnimation;
    lblParAntAutonomo: TLabel;
    recPartAntPJuridica: TRectangle;
    anmPartAntPJuridicaHeight: TFloatAnimation;
    anmPartAntPJuridicaTop: TFloatAnimation;
    lblParAntPJuridica: TLabel;
    layAtual: TLayout;
    lblParticipacaoPessoaAnoAtual: TLabel;
    recPartClienteAtu: TRectangle;
    lineParCliAtu_5: TLine;
    lblParCliAtu_5: TLabel;
    lblParCliAtu_4: TLabel;
    lineParCliAtu_4: TLine;
    lblParCliAtu_3: TLabel;
    lineParCliAtu_3: TLine;
    lblParCliAtu_2: TLabel;
    lineParCliAtu_2: TLine;
    lblParCliAtu_1: TLabel;
    lineParCliAtu_1: TLine;
    recPartAtuPFisica: TRectangle;
    anmPartAtuPFisicaHeight: TFloatAnimation;
    anmPartAtuPFisicaTop: TFloatAnimation;
    recPartAtuIndustria: TRectangle;
    anmPartAtuIndustriaHeight: TFloatAnimation;
    anmPartAtuIndustriaTop: TFloatAnimation;
    lblParAtuIndustria: TLabel;
    lblParAtuPFisica: TLabel;
    recPartAtuAutonomo: TRectangle;
    anmPartAtuAutonomoHeight: TFloatAnimation;
    anmPartAtuAutonomoTop: TFloatAnimation;
    lblParAtuAutonomo: TLabel;
    recPartAtuPJuridica: TRectangle;
    anmPartAtuPJuridicaHeight: TFloatAnimation;
    anmPartAtuPJuridicaTop: TFloatAnimation;
    lblParAtuPJuridica: TLabel;
    layUltimosMeses: TLayout;
    lblParticipacaoPessoaUltimos3Meses: TLabel;
    recPartClienteMes: TRectangle;
    lineParCliMes_5: TLine;
    lblParCliMes_5: TLabel;
    lblParCliMes_4: TLabel;
    lineParCliMes_4: TLine;
    lblParCliMes_3: TLabel;
    lineParCliMes_3: TLine;
    lblParCliMes_2: TLabel;
    lineParCliMes_2: TLine;
    lblParCliMes_1: TLabel;
    lineParCliMes_1: TLine;
    recPartMesPFisica: TRectangle;
    anmPartMesPFisicaHeight: TFloatAnimation;
    anmPartMesPFisicaTop: TFloatAnimation;
    recPartMesIndustria: TRectangle;
    anmPartMesIndustriaHeight: TFloatAnimation;
    anmPartMesIndustriaTop: TFloatAnimation;
    lblParMesIndustria: TLabel;
    lblParMesPFisica: TLabel;
    recPartMesAutonomo: TRectangle;
    anmPartMesAutonomoHeight: TFloatAnimation;
    anmPartMesAutonomoTop: TFloatAnimation;
    lblParMesAutonomo: TLabel;
    recPartMesPJuridica: TRectangle;
    anmPartMesPJuridicaHeight: TFloatAnimation;
    anmPartMesPJuridicaTop: TFloatAnimation;
    lblParMesPJuridica: TLabel;
    Line5: TLine;
    Line19: TLine;
    recParticipacaoVendasCondicao: TRectangle;
    Label17: TLabel;
    Rectangle15: TRectangle;
    FlowLayout9: TFlowLayout;
    FlowLayout10: TFlowLayout;
    Label20: TLabel;
    RoundRect18: TRoundRect;
    Label21: TLabel;
    RoundRect19: TRoundRect;
    layCondAnterior: TLayout;
    lblParticipacaoCondicaoAnoAnterior: TLabel;
    recPartCondAnt: TRectangle;
    lineParCndAnt_5: TLine;
    lblParCndAnt_5: TLabel;
    lblParCndAnt_4: TLabel;
    lineParCndAnt_4: TLine;
    lblParCndAnt_3: TLabel;
    lineParCndAnt_3: TLine;
    lblParCndAnt_2: TLabel;
    lineParCndAnt_2: TLine;
    lblParCndAnt_1: TLabel;
    lineParCndAnt_1: TLine;
    recPartAntAPrazo: TRectangle;
    anmPartAntAPrazoHeight: TFloatAnimation;
    anmPartAntAPrazoTop: TFloatAnimation;
    lblParAntAPrazo: TLabel;
    recPartAntAVista: TRectangle;
    anmPartAntAVistaHeight: TFloatAnimation;
    anmPartAntAVistaTop: TFloatAnimation;
    lblParAntAVista: TLabel;
    layCondAtual: TLayout;
    lblParticipacaoCondicaoAnoAtual: TLabel;
    recPartCondAtu: TRectangle;
    lineParCndAtu_5: TLine;
    lblParCndAtu_5: TLabel;
    lblParCndAtu_4: TLabel;
    lineParCndAtu_4: TLine;
    lblParCndAtu_3: TLabel;
    lineParCndAtu_3: TLine;
    lblParCndAtu_2: TLabel;
    lineParCndAtu_2: TLine;
    lblParCndAtu_1: TLabel;
    lineParCndAtu_1: TLine;
    recPartAtuAPrazo: TRectangle;
    anmPartAtuAPrazoHeight: TFloatAnimation;
    anmPartAtuAPrazoTop: TFloatAnimation;
    lblParAtuAPrazo: TLabel;
    recPartAtuAVista: TRectangle;
    anmPartAtuAVistaHeight: TFloatAnimation;
    anmPartAtuAVistaTop: TFloatAnimation;
    lblParAtuAVista: TLabel;
    layCondUltimosMeses: TLayout;
    lblParticipacaoCondicaoUltimos3Meses: TLabel;
    recPartCondMes: TRectangle;
    lineParCndMes_5: TLine;
    lblParCndMes_5: TLabel;
    lblParCndMes_4: TLabel;
    lineParCndMes_4: TLine;
    lblParCndMes_3: TLabel;
    lineParCndMes_3: TLine;
    lblParCndMes_2: TLabel;
    lineParCndMes_2: TLine;
    lblParCndMes_1: TLabel;
    lineParCndMes_1: TLine;
    recPartMesAPrazo: TRectangle;
    anmPartMesAPrazoHeight: TFloatAnimation;
    anmPartMesAPrazoTop: TFloatAnimation;
    lblParMesAPrazo: TLabel;
    recPartMesAVista: TRectangle;
    anmPartMesAVistaHeight: TFloatAnimation;
    anmPartMesAVistaTop: TFloatAnimation;
    lblParMesAVista: TLabel;
    Line25: TLine;
    Line26: TLine;
    Rectangle4: TRectangle;
    Label30: TLabel;
    Rectangle12: TRectangle;
    FlowLayout6: TFlowLayout;
    lblValorMedioAnt: TLabel;
    lblValorMedioAntDesc: TLabel;
    lblValorMedioAtu: TLabel;
    lblValorMedioAtuDesc: TLabel;
    FlowLayoutBreak1: TFlowLayoutBreak;
    serTicketU3M: TLineSeries;
    lblLegU3M: TLabel;
    RoundRect5: TRoundRect;
    lblLegU3M1: TLabel;
    RoundRect6: TRoundRect;
    lblLegAnoAtu: TLabel;
    RoundRect2: TRoundRect;
    lblLegAnoAnt: TLabel;
    RoundRect1: TRoundRect;
    serUltimos3M: TLineSeries;
    lblValorMedioU3M: TLabel;
    lblValorMedioU3MDesc: TLabel;
    recDescontoAplicado: TRectangle;
    Label2: TLabel;
    Rectangle11: TRectangle;
    lineDesconto_5: TLine;
    lblDesconto_5: TLabel;
    lblDesconto_4: TLabel;
    lineDesconto_4: TLine;
    lblDesconto_3: TLabel;
    lineDesconto_3: TLine;
    lblDesconto_2: TLabel;
    lineDesconto_2: TLine;
    lblDesconto_1: TLabel;
    lineDesconto_1: TLine;
    Rectangle14: TRectangle;
    anmDescontoAntHeigth: TFloatAnimation;
    anmDescontoAntTop: TFloatAnimation;
    Rectangle16: TRectangle;
    anmDescontoAtuHeigth: TFloatAnimation;
    anmDescontoAtuTop: TFloatAnimation;
    lblAnoDescontoAnt: TLabel;
    lblAnoDescontoAtu: TLabel;
    pthDesconto: TPath;
    Label22: TLabel;
    lblDescontoAtu: TLabel;
    lblDescontoAnt: TLabel;
    lblVariacaoDesconto: TLabel;
    Rectangle17: TRectangle;
    anmDescontoU3MHeigth: TFloatAnimation;
    anmDescontoU3MTop: TFloatAnimation;
    lblDescontoUltimosMeses: TLabel;
    lblDescontoU3M: TLabel;
    recMargem: TRectangle;
    Label3: TLabel;
    Rectangle5: TRectangle;
    linMargemTop: TLine;
    lblMargem5: TLabel;
    lblMargem4: TLabel;
    Line2: TLine;
    lblMargem3: TLabel;
    Line3: TLine;
    lblMargem2: TLabel;
    Line4: TLine;
    lblMargem1: TLabel;
    linMargemBotton: TLine;
    Rectangle6: TRectangle;
    anmMargemAntHeigth: TFloatAnimation;
    anmMargemAntTop: TFloatAnimation;
    Rectangle8: TRectangle;
    anmMargemAtuHeigth: TFloatAnimation;
    anmMargemAtuTop: TFloatAnimation;
    lblAnoMargemAnt: TLabel;
    lblAnoMargemAtu: TLabel;
    pthMargem: TPath;
    Label15: TLabel;
    lblMargemAtu: TLabel;
    lblMargemAnt: TLabel;
    lblVariacaoMargem: TLabel;
    Rectangle10: TRectangle;
    anmMargemUltimosMesesHeigth: TFloatAnimation;
    anmMargemUltimosMesesTop: TFloatAnimation;
    lblMargemUltimosMeses: TLabel;
    lblMargemUltimos3Meses: TLabel;
    recPositivacao: TRectangle;
    Label18: TLabel;
    Rectangle9: TRectangle;
    linPositivTop: TLine;
    lblPositiv5: TLabel;
    lblPositiv4: TLabel;
    Line7: TLine;
    lblPositiv3: TLabel;
    Line8: TLine;
    lblPositiv2: TLabel;
    Line9: TLine;
    lblPositiv1: TLabel;
    linPositivBotton: TLine;
    recPositivacaoAnt: TRectangle;
    anmPositvAntHeigth: TFloatAnimation;
    anmPositvAntTop: TFloatAnimation;
    recPositivacaoAtu: TRectangle;
    anmPositvAtuHeigth: TFloatAnimation;
    anmPositvAtuTop: TFloatAnimation;
    lblAnoPositivacaoAnt: TLabel;
    lblAnoPositivacaoAtu: TLabel;
    pthPositivacao: TPath;
    Label26: TLabel;
    lblPositivacaoAtu: TLabel;
    lblPositivacaoAnt: TLabel;
    lblVariacaoPositivacao: TLabel;
    recPositivacaoMes: TRectangle;
    anmPositvMesHeigth: TFloatAnimation;
    anmPositvMesTop: TFloatAnimation;
    lbl3MesesPositivacao: TLabel;
    lblPositivacaoUltimos3meses: TLabel;
    procedure serTicketClickPointer(Sender: TCustomSeries; ValueIndex, X,
      Y: Integer);
    procedure serValorClickPointer(Sender: TCustomSeries; ValueIndex, X,
      Y: Integer);
    procedure anmPositvAntHeigthFinish(Sender: TObject);
    procedure anmPositvAtuHeigthFinish(Sender: TObject);
    procedure anmMargemAntHeigthFinish(Sender: TObject);
    procedure anmMargemAtuHeigthFinish(Sender: TObject);
    procedure anmPartAtuPJuridicaHeightFinish(Sender: TObject);
    procedure anmPartAtuPFisicaHeightFinish(Sender: TObject);
    procedure anmPartAntPJuridicaHeightFinish(Sender: TObject);
    procedure anmPartAntPFisicaHeightFinish(Sender: TObject);
    procedure anmPartAntIndustriaHeightFinish(Sender: TObject);
    procedure anmPartAntAutonomoHeightFinish(Sender: TObject);
    procedure anmPartAtuIndustriaHeightFinish(Sender: TObject);
    procedure anmPartAtuAutonomoHeightFinish(Sender: TObject);
    procedure anmPartMesPJuridicaHeightFinish(Sender: TObject);
    procedure anmPartMesPFisicaHeightFinish(Sender: TObject);
    procedure anmPartMesIndustriaHeightFinish(Sender: TObject);
    procedure anmPartMesAutonomoHeightFinish(Sender: TObject);
    procedure anmPartAntAVistaHeightFinish(Sender: TObject);
    procedure anmPartAntAPrazoHeightFinish(Sender: TObject);
    procedure anmPartAtuAPrazoHeightFinish(Sender: TObject);
    procedure anmPartAtuAVistaHeightFinish(Sender: TObject);
    procedure anmPartMesAVistaHeightFinish(Sender: TObject);
    procedure anmPartMesAPrazoHeightFinish(Sender: TObject);
    procedure anmPositvMesHeigthFinish(Sender: TObject);
    procedure anmMargemUltimosMesesHeigthFinish(Sender: TObject);
    procedure anmDescontoAntHeigthFinish(Sender: TObject);
    procedure anmDescontoAtuHeigthFinish(Sender: TObject);
    procedure anmDescontoU3MHeigthFinish(Sender: TObject);
  private
    intQtdAnt,
    intQtdAtu,
    intPerMaxPartPes,
    intPerMaxPartCnd: Integer;
    fltQtdU3M,
    fltValAnt,
    fltValAtu,
    fltValU3M: Double;
    fltParPrazoAtu,
    fltParVistaAtu,
    fltParPrazoAnt,
    fltParVistaAnt,
    fltParPrazoU3M,
    fltParVistaU3M,
    fltValorTotalCndAtu,
    fltValorTotalCndAnt,
    fltValorTotalCndU3M: Double;
    fltParAntPFisica,
    fltParAtuPFisica,
    fltParU3MPFisica,
    fltParAntAutonomo,
    fltParAtuAutonomo,
    fltParU3MAutonomo,
    fltParAntPJuridica,
    fltParAtuPJuridica,
    fltParU3MPJuridica,
    fltParAntIndustria,
    fltParAtuIndustria,
    fltParU3MIndustria,
    fltValorTotalParAtu,
    fltValorTotalParAnt,
    fltValorTotalParU3M: Double;

    procedure pAnimarGraficos;
    procedure pCarregaQuantidadesVenda();
    procedure pCarregaValoresVenda();
    procedure pCarregaParticipacao();
    procedure pCarregaParticipacaoCndAnoAtual();
    procedure pCarregaParticipacaoCndAnoAnterior();
    procedure pCarregaParticipacaoPessoaAnoAtual();
    procedure pCarregaParticipacaoCndUtimos3Meses();
    procedure pCarregaParticipacaoPessoaAnoAnterior();
    procedure pCarregaParticipacaoPessoaUltimos3Meses();
    function fQtdClientesPositivados(dteDtaIni, dteDtaFin: TDate; strCodDep: String = ''): Integer;
    procedure pCarregaMargemLucro();
    procedure pCarregaPositivacao();
    procedure pCarregaValorMedioVenda();
    procedure pCarregaDescontoAplicado();
  protected
  public
    procedure pCarregaDados(); override;
  end;

var
  fraComparativo: TfraComparativo;

implementation

{$R *.fmx}

{ TfraComparativo }

procedure TfraComparativo.anmDescontoAntHeigthFinish(Sender: TObject);
begin
  inherited;
  lblDescontoAnt.Visible := True;
end;

procedure TfraComparativo.anmDescontoAtuHeigthFinish(Sender: TObject);
begin
  inherited;
  lblDescontoAtu.Visible := True;
end;

procedure TfraComparativo.anmDescontoU3MHeigthFinish(Sender: TObject);
begin
  inherited;
  lblDescontoU3M.Visible := True;
end;

procedure TfraComparativo.anmMargemAntHeigthFinish(Sender: TObject);
begin
  inherited;
  lblMargemAnt.Visible := True;
end;

procedure TfraComparativo.anmMargemAtuHeigthFinish(Sender: TObject);
begin
  inherited;
  lblMargemAtu.Visible := True;
end;

procedure TfraComparativo.anmMargemUltimosMesesHeigthFinish(Sender: TObject);
begin
  inherited;
  lblMargemUltimos3Meses.Visible := True;
end;

procedure TfraComparativo.anmPartAntAutonomoHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAntAutonomo.Visible := True;
end;

procedure TfraComparativo.anmPartAntIndustriaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAntIndustria.Visible := True;
end;

procedure TfraComparativo.anmPartAntPFisicaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAntPFisica.Visible := True;
end;

procedure TfraComparativo.anmPartAntPJuridicaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAntPJuridica.Visible := True;
end;

procedure TfraComparativo.anmPartAtuAPrazoHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAtuAPrazo.Visible := True;
end;

procedure TfraComparativo.anmPartAtuAutonomoHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAtuAutonomo.Visible := True;
end;

procedure TfraComparativo.anmPartAtuAVistaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAtuAVista.Visible := True;
end;

procedure TfraComparativo.anmPartAtuIndustriaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAtuIndustria.Visible := True;
end;

procedure TfraComparativo.anmPartAtuPFisicaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAtuPFisica.Visible := True;
end;

procedure TfraComparativo.anmPartAtuPJuridicaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAtuPJuridica.Visible := True;
end;

procedure TfraComparativo.anmPartMesAPrazoHeightFinish(Sender: TObject);
begin
  inherited;
  lblParMesAPrazo.Visible := True;
end;

procedure TfraComparativo.anmPartMesAutonomoHeightFinish(Sender: TObject);
begin
  inherited;
  lblParMesAutonomo.Visible := True;
end;

procedure TfraComparativo.anmPartMesAVistaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParMesAVista.Visible := True;
end;

procedure TfraComparativo.anmPartMesIndustriaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParMesIndustria.Visible := True;
end;

procedure TfraComparativo.anmPartMesPFisicaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParMesPFisica.Visible := True;
end;

procedure TfraComparativo.anmPartMesPJuridicaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParMesPJuridica.Visible := True;
end;

procedure TfraComparativo.anmPositvMesHeigthFinish(
  Sender: TObject);
begin
  inherited;
  lblPositivacaoUltimos3meses.Visible := True;
end;

procedure TfraComparativo.anmPositvAntHeigthFinish(Sender: TObject);
begin
  inherited;
  lblPositivacaoAnt.Visible := True;
end;

procedure TfraComparativo.anmPositvAtuHeigthFinish(Sender: TObject);
begin
  inherited;
  lblPositivacaoAtu.Visible := True;
end;

function TfraComparativo.fQtdClientesPositivados(dteDtaIni, dteDtaFin: TDate; strCodDep: String = ''): Integer;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + '  COUNT(CLI_CODCLI) AS QTD ';
  strSQL := strSQL + 'FROM                       ';
  strSQL := strSQL + '  CADCLI                   ';
  strSQL := strSQL + 'WHERE CLI_DTACAD BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDtaIni)) + ' AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDtaFin));
  If Not blnDireitoGeral Then
  Begin
    strSQL := strSQL + '  AND (CLI_CODVEN = ' + QuotedStr(strLogOpe) + ' ';
    If blnDireitoEquipe And (strCodDep <> '') Then
    Begin
      strSQL := strSQL + '   OR CLI_CODVEN IN ';
      strSQL := strSQL + '   (SELECT          ';
      strSQL := strSQL + '      OPE_CODOPE    ';
      strSQL := strSQL + '    FROM            ';
      strSQL := strSQL + '      CADOPE        ';
      strSQL := strSQL + '    WHERE OPE_CODDEP = ' + QuotedStr(strCodDep);
      strSQL := strSQL + '   )';
    End;
    strSQL := strSQL + '  )';
  End;
  strSQL := strSQL + '  AND CLI_STATUS = "A"     ';

  qryAux.Close;
  qryAux.SQL.Text := strSQL;
  qryAux.Open;

  Result := qryAux.FieldValue('QTD');
end;

procedure TfraComparativo.pAnimarGraficos;
  Var
    i: Integer;
begin
  for i := 0 to Self.ComponentCount -1 do
  begin
    if (Self.Components[i] is TFloatAnimation) then
    begin
      (Self.Components[i] as TFloatAnimation).Delay    := 0;
      If (Self.Components[i].Name <> 'anmValorVendas') And
         (Self.Components[i].Name <> 'anmValorTickets') Then
        (Self.Components[i] as TFloatAnimation).Duration := 2;
      (Self.Components[i] as TFloatAnimation).Enabled  := True;
    end;
  end;
end;

procedure TfraComparativo.pCarregaDados;
begin
  pIniciaVariaveis();

  fltParPrazoAtu := 0;
  fltParVistaAtu := 0;
  fltParPrazoAnt := 0;
  fltParVistaAnt := 0;
  fltParPrazoU3M := 0;
  fltParVistaU3M := 0;
  intPerMaxPartPes := 0;
  intPerMaxPartCnd := 0;
  fltParAntPFisica := 0;
  fltParAtuPFisica := 0;
  fltParU3MPFisica := 0;
  fltParAntAutonomo := 0;
  fltParAtuAutonomo := 0;
  fltParU3MAutonomo := 0;
  fltParAntPJuridica := 0;
  fltParAtuPJuridica := 0;
  fltParU3MPJuridica := 0;
  fltParAntIndustria := 0;
  fltParAtuIndustria := 0;
  fltParU3MIndustria := 0;
  fltValorTotalParAtu := 0;
  fltValorTotalParAnt := 0;
  fltValorTotalParU3M := 0;
  fltValorTotalCndAtu := 0;
  fltValorTotalCndAnt := 0;
  fltValorTotalCndU3M := 0;

  pCarregaValoresVenda();
  pCarregaQuantidadesVenda();
  pCarregaParticipacao();
  If fTemDireitoAcesso('DASHBOARD_VER_MARGEM') Then
    pCarregaMargemLucro()
  Else
    recMargem.Destroy;
  pCarregaPositivacao();
  pCarregaValorMedioVenda();
  pCarregaDescontoAplicado();

  pAnimarGraficos;

  lblAnoAntDesc.Text  := 'Total em ' + fMesComp(intMes) + ' de ' + lblLegAnoAnt.Text;
  lblAnoAtuDesc.Text  := 'Total em ' + fMesComp(intMes) + ' de ' + lblLegAnoAtu.Text;

  lblAnoAntTicketsDesc.Text  := 'Total em ' + fMesComp(intMes) + ' de ' + lblLegAnoAnt2.Text;
  lblAnoAtuTicketsDesc.Text  := 'Total em ' + fMesComp(intMes) + ' de ' + lblLegAnoAtu2.Text;
end;

procedure TfraComparativo.pCarregaDescontoAplicado;
var
  intDescontoAtu, intDescontoAnt, intDescontoU3M, intMax: Integer;
  blnAumentou: Boolean;
  extTotalHeight: Extended;
begin
  intDescontoAtu := 0;
  intDescontoAnt := 0;
  intDescontoU3M := 0;

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteDtaIni, dteDtaFin, trDescontoAplicado, taNenhum, strCodDeptoUsuarioLogado);
  qryAux.Open;
  If qryAux.FieldValue('VALOR') <> null Then
    intDescontoAtu := Round(qryAux.FieldValue('VALOR'));

  intMax := intDescontoAtu;

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteAntIni, dteAntFin, trDescontoAplicado, taNenhum, strCodDeptoUsuarioLogado);
  qryAux.Open;
  If qryAux.FieldValue('VALOR') <> null Then
    intDescontoAnt := Round(qryAux.FieldValue('VALOR'));

  If intDescontoAnt > intMax Then
    intMax := intDescontoAnt;

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(DataAntIni, DataAntFin, trDescontoAplicado, taMedia, strCodDeptoUsuarioLogado);
  qryAux.Open;
  If qryAux.FieldValue('VALOR') <> null Then
    intDescontoU3M := Round(qryAux.FieldValue('VALOR'));

  If intDescontoU3M > intMax Then
    intMax := intDescontoU3M;

  lblAnoDescontoAtu.Text := IntToStr(intAnoAtu);
  lblAnoDescontoAnt.Text := IntToStr(intAnoAnt);

  blnAumentou := intDescontoAtu >= intDescontoAnt;
  intMax := ((intMax div 10) + 1) * 10;

  lblDesconto_2.Text := IntToStr(intMax div 4);
  lblDesconto_3.Text := IntToStr(intMax div 2);
  lblDesconto_4.Text := IntToStr((intMax div 4) * 3);
  lblDesconto_5.Text := IntToStr(intMax);

  extTotalHeight := lineDesconto_1.Position.Y - lineDesconto_5.Position.Y;

  anmDescontoAntHeigth.StopValue := intDescontoAnt * extTotalHeight / intMax;
  anmDescontoAntTop.StopValue := lineDesconto_1.Position.Y - anmDescontoAntHeigth.StopValue;

  anmDescontoAtuHeigth.StopValue := intDescontoAtu * extTotalHeight / intMax;
  anmDescontoAtuTop.StopValue := lineDesconto_1.Position.Y - anmDescontoAtuHeigth.StopValue;

  anmDescontoU3MHeigth.StopValue := intDescontoU3M * extTotalHeight / intMax;
  anmDescontoU3MTop.StopValue := lineDesconto_1.Position.Y -  anmDescontoU3MHeigth.StopValue;

  lblDescontoAnt.Position.Y := anmDescontoAntTop.StopValue - lblDescontoAnt.Height;
  lblDescontoAtu.Position.Y := anmDescontoAtuTop.StopValue - lblDescontoAtu.Height;
  lblDescontoU3M.Position.Y := anmDescontoU3MTop.StopValue - lblDescontoU3M.Height;
  lblDescontoAnt.Text := IntToStr(intDescontoAnt) + '%';
  lblDescontoAtu.Text := IntToStr(intDescontoAtu) + '%';
  lblDescontoU3M.Text := IntToStr(intDescontoU3M) + '%';
  lblVariacaoDesconto.Text := IntToStr(intDescontoAtu - intDescontoAnt) + '%';

  if Not blnAumentou Then
  Begin
    pthDesconto.RotationAngle := 180;
    pthDesconto.Fill.Color := $FFC56C6C;
  End;
end;

procedure TfraComparativo.pCarregaMargemLucro;
var
  intMargemAtu, intMargemAnt, intMargemU3M, intMax: Integer;
  blnAumentou: Boolean;
  extTotalHeight: Extended;
begin
  intMargemAtu := 0;
  intMargemAnt := 0;
  intMargemU3M := 0;

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteDtaIni, dteDtaFin, trMargemLucro, taNenhum, strCodDeptoUsuarioLogado);
  qryAux.Open;
  If qryAux.FieldValue('VALOR') <> null Then
    intMargemAtu := Round(qryAux.FieldValue('VALOR'));

  intMax := intMargemAtu;

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteAntIni, dteAntFin, trMargemLucro, taNenhum, strCodDeptoUsuarioLogado);
  qryAux.Open;
  If qryAux.FieldValue('VALOR') <> null Then
    intMargemAnt := Round(qryAux.FieldValue('VALOR'));

  If intMargemAnt > intMax Then
    intMax := intMargemAnt;

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(DataAntIni, DataAntFin, trMargemLucro, taMedia, strCodDeptoUsuarioLogado);
  qryAux.Open;
  If qryAux.FieldValue('VALOR') <> null Then
    intMargemU3M := Round(qryAux.FieldValue('VALOR'));

  If intMargemU3M > intMax Then
    intMax := intMargemU3M;

  lblAnoMargemAtu.Text := IntToStr(intAnoAtu);
  lblAnoMargemAnt.Text := IntToStr(intAnoAnt);

  blnAumentou := intMargemAtu >= intMargemAnt;
  intMax := ((intMax div 10) + 1) * 10;

  lblMargem2.Text := IntToStr(intMax div 4);
  lblMargem3.Text := IntToStr(intMax div 2);
  lblMargem4.Text := IntToStr((intMax div 4) * 3);
  lblMargem5.Text := IntToStr(intMax);

  extTotalHeight := linMargemBotton.Position.Y - linMargemTop.Position.Y;

  anmMargemAntHeigth.StopValue := intMargemAnt * extTotalHeight / intMax;
  anmMargemAntTop.StopValue := linMargemBotton.Position.Y - anmMargemAntHeigth.StopValue;
  anmMargemAtuHeigth.StopValue := intMargemAtu * extTotalHeight / intMax;
  anmMargemAtuTop.StopValue := linMargemBotton.Position.Y - anmMargemAtuHeigth.StopValue;
  anmMargemUltimosMesesHeigth.StopValue := intMargemU3M * extTotalHeight / intMax;
  anmMargemUltimosMesesTop.StopValue := linMargemBotton.Position.Y -  anmMargemUltimosMesesHeigth.StopValue;

  lblMargemAnt.Position.Y := anmMargemAntTop.StopValue - lblMargemAnt.Height;
  lblMargemAtu.Position.Y := anmMargemAtuTop.StopValue - lblMargemAtu.Height;
  lblMargemUltimos3Meses.Position.Y := anmMargemUltimosMesesTop.StopValue - lblMargemUltimos3Meses.Height;
  lblMargemAnt.Text := IntToStr(intMargemAnt) + '%';
  lblMargemAtu.Text := IntToStr(intMargemAtu) + '%';
  lblMargemUltimos3Meses.Text := IntToStr(intMargemU3M) + '%';
  lblVariacaoMargem.Text := IntToStr(intMargemAtu - intMargemAnt) + '%';

  if Not blnAumentou Then
  Begin
    pthMargem.RotationAngle := 180;
    pthMargem.Fill.Color := $FFC56C6C;
  End;
end;

procedure TfraComparativo.pCarregaParticipacao;
var
  extTotalHeight: Extended;
begin
  lblParticipacaoCondicaoAnoAnterior.Text := IntToStr(intAnoAnt);

  pCarregaParticipacaoPessoaAnoAtual();
  pCarregaParticipacaoPessoaAnoAnterior();
  pCarregaParticipacaoPessoaUltimos3Meses();

  intPerMaxPartPes := ((intPerMaxPartPes Div 10) + 1) * 10;

  If intPerMaxPartPes > 100 Then
    intPerMaxPartPes := 100;

  lblParCliAnt_2.Text := IntToStr(intPerMaxPartPes Div 4);
  lblParCliAnt_3.Text := IntToStr(intPerMaxPartPes Div 2);
  lblParCliAnt_4.Text := IntToStr((intPerMaxPartPes Div 4) * 3);
  lblParCliAnt_5.Text := IntToStr(intPerMaxPartPes);

  lblParCliAtu_2.Text := lblParCliAnt_2.Text;
  lblParCliAtu_3.Text := lblParCliAnt_3.Text;
  lblParCliAtu_4.Text := lblParCliAnt_4.Text;
  lblParCliAtu_5.Text := lblParCliAnt_5.Text;

  lblParCliMes_2.Text := lblParCliAnt_2.Text;
  lblParCliMes_3.Text := lblParCliAnt_3.Text;
  lblParCliMes_4.Text := lblParCliAnt_4.Text;
  lblParCliMes_5.Text := lblParCliAnt_5.Text;

  extTotalHeight := lineParCliAtu_1.Position.Y - lineParCliAtu_5.Position.Y;

  {Ano Atual}
  anmPartAtuPJuridicaHeight.StopValue := Round((fltParAtuPJuridica / fltValorTotalParAtu) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartAtuPJuridicaTop.StopValue := lineParCliAtu_1.Position.Y - anmPartAtuPJuridicaHeight.StopValue;
  lblParAtuPJuridica.Position.Y := anmPartAtuPJuridicaTop.StopValue - lblParAtuPJuridica.Height;
  lblParAtuPJuridica.Text := IntToStr(Round((fltParAtuPJuridica / fltValorTotalParAtu) * 100)) + '%';

  anmPartAtuPFisicaHeight.StopValue := Round((fltParAtuPFisica / fltValorTotalParAtu) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartAtuPFisicaTop.StopValue := lineParCliAtu_1.Position.Y - anmPartAtuPFisicaHeight.StopValue;
  lblParAtuPFisica.Position.Y := anmPartAtuPFisicaTop.StopValue - lblParAtuPFisica.Height;
  lblParAtuPFisica.Text := IntToStr(Round((fltParAtuPFisica / fltValorTotalParAtu) * 100)) + '%';

  anmPartAtuIndustriaHeight.StopValue := Round((fltParAtuIndustria / fltValorTotalParAtu) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartAtuIndustriaTop.StopValue := lineParCliAtu_1.Position.Y - anmPartAtuIndustriaHeight.StopValue;
  lblParAtuIndustria.Position.Y := anmPartAtuIndustriaTop.StopValue - lblParAtuIndustria.Height;
  lblParAtuIndustria.Text := IntToStr(Round((fltParAtuIndustria / fltValorTotalParAtu) * 100)) + '%';

  anmPartAtuAutonomoHeight.StopValue := Round((fltParAtuAutonomo / fltValorTotalParAtu) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartAtuAutonomoTop.StopValue := lineParCliAtu_1.Position.Y - anmPartAtuAutonomoHeight.StopValue;
  lblParAtuAutonomo.Position.Y := anmPartAtuAutonomoTop.StopValue - lblParAtuAutonomo.Height;
  lblParAtuAutonomo.Text := IntToStr(Round((fltParAtuAutonomo / fltValorTotalParAtu) * 100)) + '%';

  {Ano Anterior}
  anmPartAntPJuridicaHeight.StopValue := Round((fltParAntPJuridica / fltValorTotalParAnt) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartAntPJuridicaTop.StopValue := lineParCliAnt_1.Position.Y - anmPartAntPJuridicaHeight.StopValue;
  lblParAntPJuridica.Position.Y := anmPartAntPJuridicaTop.StopValue - lblParAntPJuridica.Height;
  lblParAntPJuridica.Text := IntToStr(Round((fltParAntPJuridica / fltValorTotalParAnt) * 100)) + '%';

  anmPartAntPFisicaHeight.StopValue := Round((fltParAntPFisica / fltValorTotalParAnt) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartAntPFisicaTop.StopValue := lineParCliAnt_1.Position.Y - anmPartAntPFisicaHeight.StopValue;
  lblParAntPFisica.Position.Y := anmPartAntPFisicaTop.StopValue - lblParAntPFisica.Height;
  lblParAntPFisica.Text := IntToStr(Round((fltParAntPFisica / fltValorTotalParAnt) * 100)) + '%';

  anmPartAntIndustriaHeight.StopValue := Round((fltParAntIndustria / fltValorTotalParAnt) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartAntIndustriaTop.StopValue := lineParCliAnt_1.Position.Y - anmPartAntIndustriaHeight.StopValue;
  lblParAntIndustria.Position.Y := anmPartAntIndustriaTop.StopValue - lblParAntIndustria.Height;
  lblParAntIndustria.Text := IntToStr(Round((fltParAntIndustria / fltValorTotalParAnt) * 100)) + '%';

  anmPartAntAutonomoHeight.StopValue := Round((fltParAntAutonomo / fltValorTotalParAnt) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartAntAutonomoTop.StopValue := lineParCliAnt_1.Position.Y - anmPartAntAutonomoHeight.StopValue;
  lblParAntAutonomo.Position.Y := anmPartAntAutonomoTop.StopValue - lblParAntAutonomo.Height;
  lblParAntAutonomo.Text := IntToStr(Round((fltParAntAutonomo / fltValorTotalParAnt) * 100)) + '%';

  {Três Últimos Meses}
  anmPartMesPJuridicaHeight.StopValue := Round((fltParU3MPJuridica / fltValorTotalParU3M) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartMesPJuridicaTop.StopValue := lineParCliMes_1.Position.Y - anmPartMesPJuridicaHeight.StopValue;
  lblParMesPJuridica.Position.Y := anmPartMesPJuridicaTop.StopValue - lblParMesPJuridica.Height;
  lblParMesPJuridica.Text := IntToStr(Round((fltParU3MPJuridica / fltValorTotalParU3M) * 100)) + '%';

  anmPartMesPFisicaHeight.StopValue := Round((fltParU3MPFisica / fltValorTotalParU3M) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartMesPFisicaTop.StopValue := lineParCliMes_1.Position.Y - anmPartMesPFisicaHeight.StopValue;
  lblParMesPFisica.Position.Y := anmPartMesPFisicaTop.StopValue - lblParMesPFisica.Height;
  lblParMesPFisica.Text := IntToStr(Round((fltParU3MPFisica / fltValorTotalParU3M) * 100)) + '%';

  anmPartMesIndustriaHeight.StopValue := Round((fltParU3MIndustria / fltValorTotalParU3M) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartMesIndustriaTop.StopValue := lineParCliAnt_1.Position.Y - anmPartMesIndustriaHeight.StopValue;
  lblParMesIndustria.Position.Y := anmPartMesIndustriaTop.StopValue - lblParMesIndustria.Height;
  lblParMesIndustria.Text := IntToStr(Round((fltParU3MIndustria / fltValorTotalParU3M) * 100)) + '%';

  anmPartMesAutonomoHeight.StopValue := Round((fltParU3MAutonomo / fltValorTotalParU3M) * 100) * extTotalHeight / intPerMaxPartPes;
  anmPartMesAutonomoTop.StopValue := lineParCliMes_1.Position.Y - anmPartMesAutonomoHeight.StopValue;
  lblParMesAutonomo.Position.Y := anmPartMesAutonomoTop.StopValue - lblParMesAutonomo.Height;
  lblParMesAutonomo.Text := IntToStr(Round((fltParU3MAutonomo / fltValorTotalParU3M) * 100)) + '%';

  {Condição de pagamento}
  pCarregaParticipacaoCndAnoAtual();
  pCarregaParticipacaoCndAnoAnterior();
  pCarregaParticipacaoCndUtimos3Meses();

  intPerMaxPartCnd := ((intPerMaxPartCnd Div 10) + 1) * 10;

  If intPerMaxPartCnd > 100 Then
    intPerMaxPartCnd := 100;

  lblParCndAnt_2.Text := IntToStr(intPerMaxPartPes Div 4);
  lblParCndAnt_3.Text := IntToStr(intPerMaxPartPes Div 2);
  lblParCndAnt_4.Text := IntToStr((intPerMaxPartPes Div 4) * 3);
  lblParCndAnt_5.Text := IntToStr(intPerMaxPartPes);

  lblParCndAtu_2.Text := lblParCndAnt_2.Text;
  lblParCndAtu_3.Text := lblParCndAnt_3.Text;
  lblParCndAtu_4.Text := lblParCndAnt_4.Text;
  lblParCndAtu_5.Text := lblParCndAnt_5.Text;

  lblParCndMes_2.Text := lblParCndAnt_2.Text;
  lblParCndMes_3.Text := lblParCndAnt_3.Text;
  lblParCndMes_4.Text := lblParCndAnt_4.Text;
  lblParCndMes_5.Text := lblParCndAnt_5.Text;

  extTotalHeight := lineParCndAtu_1.Position.Y - lineParCndAtu_5.Position.Y;

  {Ano Atual}
  anmPartAtuAVistaHeight.StopValue := Round((fltParVistaAtu / fltValorTotalCndAtu) * 100) * extTotalHeight / intPerMaxPartCnd;
  anmPartAtuAVistaTop.StopValue := lineParCndAtu_1.Position.Y - anmPartAtuAVistaHeight.StopValue;
  lblParAtuAVista.Position.Y := anmPartAtuAVistaTop.StopValue - lblParAtuAVista.Height;
  lblParAtuAVista.Text := IntToStr(Round((fltParVistaAtu / fltValorTotalCndAtu) * 100)) + '%';

  anmPartAtuAPrazoHeight.StopValue := Round((fltParPrazoAtu / fltValorTotalCndAtu) * 100) * extTotalHeight / intPerMaxPartCnd;
  anmPartAtuAPrazoTop.StopValue := lineParCndAtu_1.Position.Y - anmPartAtuAPrazoHeight.StopValue;
  lblParAtuAPrazo.Position.Y := anmPartAtuAPrazoTop.StopValue - lblParAtuAPrazo.Height;
  lblParAtuAPrazo.Text := IntToStr(Round((fltParPrazoAtu / fltValorTotalCndAtu) * 100)) + '%';

  {Ano Anterior}
  anmPartAntAVistaHeight.StopValue := Round((fltParVistaAnt / fltValorTotalCndAnt) * 100) * extTotalHeight / intPerMaxPartCnd;
  anmPartAntAVistaTop.StopValue := lineParCndAnt_1.Position.Y - anmPartAntAVistaHeight.StopValue;
  lblParAntAVista.Position.Y := anmPartAntAVistaTop.StopValue - lblParAntAVista.Height;
  lblParAntAVista.Text := IntToStr(Round((fltParVistaAnt / fltValorTotalCndAnt) * 100)) + '%';

  anmPartAntAPrazoHeight.StopValue := Round((fltParPrazoAnt / fltValorTotalCndAnt) * 100) * extTotalHeight / intPerMaxPartCnd;
  anmPartAntAPrazoTop.StopValue := lineParCndAnt_1.Position.Y - anmPartAntAPrazoHeight.StopValue;
  lblParAntAPrazo.Position.Y := anmPartAntAPrazoTop.StopValue - lblParAntAPrazo.Height;
  lblParAntAPrazo.Text := IntToStr(Round((fltParPrazoAnt / fltValorTotalCndAnt) * 100)) + '%';

  {Últimos 3 Meses}
  anmPartMesAVistaHeight.StopValue := Round((fltParVistaU3M / fltValorTotalCndU3M) * 100) * extTotalHeight / intPerMaxPartCnd;
  anmPartMesAVistaTop.StopValue := lineParCndMes_1.Position.Y - anmPartMesAVistaHeight.StopValue;
  lblParMesAVista.Position.Y := anmPartMesAVistaTop.StopValue - lblParMesAVista.Height;
  lblParMesAVista.Text := IntToStr(Round((fltParVistaU3M / fltValorTotalCndU3M) * 100)) + '%';

  anmPartMesAPrazoHeight.StopValue := Round((fltParPrazoU3M / fltValorTotalCndU3M) * 100) * extTotalHeight / intPerMaxPartCnd;
  anmPartMesAPrazoTop.StopValue := lineParCndMes_1.Position.Y - anmPartMesAPrazoHeight.StopValue;
  lblParMesAPrazo.Position.Y := anmPartMesAPrazoTop.StopValue - lblParMesAPrazo.Height;
  lblParMesAPrazo.Text := IntToStr(Round((fltParPrazoU3M / fltValorTotalCndU3M) * 100)) + '%';
end;

procedure TfraComparativo.pCarregaParticipacaoCndAnoAnterior;
var
  fltValor,
  fltMaior: Double;
  intPerMax: Integer;
begin
  lblParticipacaoCondicaoAnoAnterior.Text := IntToStr(intAnoAnt);

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteAntIni, dteAntFin, trValorVenda, taTipoPrazo, strCodDeptoUsuarioLogado);
  qryAux.Open;

  fltMaior := 0.0;
  fltValorTotalCndAnt := 0.0;

  qryAux.First;
  While Not qryAux.Eof Do
  Begin
    If qryAux.FieldValue('VALOR') <> null Then
    Begin
      If qryAux.FieldValue('VALOR') > fltMaior Then
        fltMaior := qryAux.FieldValue('VALOR');

      fltValorTotalCndAnt := fltValorTotalCndAnt + qryAux.FieldValue('VALOR');
    End;

    qryAux.Next;
  End;

  intPerMax := Round((fltMaior / fltValorTotalCndAnt) * 100);
  If intPerMax > intPerMaxPartCnd Then
    intPerMaxPartCnd := intPerMax;

  qryAux.First;

  While Not qryAux.Eof Do
  Begin
    fltValor := 0.0;
    If qryAux.FieldValue('VALOR') <> null Then
      fltValor := qryAux.FieldValue('VALOR');

    If qryAux.FieldValue('GER_PRAZO') = 1 Then
      fltParVistaAnt := fltValor
    Else
      fltParPrazoAnt := fltValor;

    qryAux.Next;
  End;
end;

procedure TfraComparativo.pCarregaParticipacaoCndAnoAtual;
var
  fltValor,
  fltMaior: Double;
  intPerMax: Integer;
begin
  lblParticipacaoCondicaoAnoAtual.Text := IntToStr(intAnoAtu);

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteDtaIni, dteDtaFin, trValorVenda, taTipoPrazo, strCodDeptoUsuarioLogado);
  qryAux.Open;

  fltMaior := 0.0;
  fltValorTotalCndAtu := 0.0;

  qryAux.First;
  While Not qryAux.Eof Do
  Begin
    If qryAux.FieldValue('VALOR') <> null Then
    Begin
      If qryAux.FieldValue('VALOR') > fltMaior Then
        fltMaior := qryAux.FieldValue('VALOR');

      If qryAux.FieldValue('VALOR') > 0.00 Then
        fltValorTotalCndAtu := fltValorTotalCndAtu + qryAux.FieldValue('VALOR');
    End;

    qryAux.Next;
  End;

  intPerMax := Round((fltMaior / fltValorTotalCndAtu) * 100);
  If intPerMax > intPerMaxPartCnd Then
    intPerMaxPartCnd := intPerMax;

  qryAux.First;

  While Not qryAux.Eof Do
  Begin
    fltValor := 0.0;
    If qryAux.FieldValue('VALOR') <> null Then
      fltValor := qryAux.FieldValue('VALOR');

    If qryAux.FieldValue('GER_PRAZO') = 1 Then
      fltParVistaAtu := fltValor
    Else
      fltParPrazoAtu := fltValor;

    qryAux.Next;
  End;
end;

procedure TfraComparativo.pCarregaParticipacaoCndUtimos3Meses;
var
  fltValor,
  fltMaior: Double;
  intPerMax: Integer;
begin
  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(DataAntIni, DataAntFin, trValorVenda, taTipoPrazo, strCodDeptoUsuarioLogado);
  qryAux.Open;

  fltMaior := 0.0;
  fltValorTotalCndU3M := 0.0;

  qryAux.First;
  While Not qryAux.Eof Do
  Begin
    If qryAux.FieldValue('VALOR') <> null Then
    Begin
      If qryAux.FieldValue('VALOR') > fltMaior Then
        fltMaior := qryAux.FieldValue('VALOR');

      fltValorTotalCndU3M := fltValorTotalCndU3M + qryAux.FieldValue('VALOR');
    End;

    qryAux.Next;
  End;

  intPerMax := Round((fltMaior / fltValorTotalCndU3M) * 100);
  If intPerMax > intPerMaxPartCnd Then
    intPerMaxPartCnd := intPerMax;

  qryAux.First;

  While Not qryAux.Eof Do
  Begin
    fltValor := 0.0;
    If qryAux.FieldValue('VALOR') <> null Then
      fltValor := qryAux.FieldValue('VALOR');

    If qryAux.FieldValue('GER_PRAZO') = 1 Then
      fltParVistaU3M := fltValor
    Else
      fltParPrazoU3M := fltValor;

    qryAux.Next;
  End;
end;

procedure TfraComparativo.pCarregaParticipacaoPessoaAnoAnterior;
var
  fltValor,
  fltMaior: Double;
  intPerMax: Integer;
begin
  lblParticipacaoPessoaAnoAnterior.Text := IntToStr(intAnoAnt);

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteAntIni, dteAntFin, trValorVenda, taTipoPessoa, strCodDeptoUsuarioLogado);
  qryAux.Open;

  fltMaior := 0.00;
  fltValorTotalParAnt := 0.00;

  qryAux.First;
  While Not qryAux.Eof Do
  Begin
    If qryAux.FieldValue('VALOR') <> null Then
    Begin
      If qryAux.FieldValue('VALOR') > fltMaior Then
        fltMaior := qryAux.FieldValue('VALOR');

      fltValorTotalParAnt := fltValorTotalParAnt + qryAux.FieldValue('VALOR');
    End;
    qryAux.Next;
  End;

  intPerMax := Round((fltMaior / fltValorTotalParAnt) * 100);
  If intPerMax > intPerMaxPartPes Then
    intPerMaxPartPes := intPerMax;

  qryAux.First;

  While Not qryAux.Eof Do
  Begin
    fltValor := 0.0;
    If qryAux.FieldValue('VALOR') <> null Then
      fltValor := qryAux.FieldValue('VALOR');

    If qryAux.FieldValue('CLI_CGCCPF') = 'J' Then
      fltParAntPJuridica := fltValor
    Else If qryAux.FieldValue('CLI_CGCCPF') = 'F' Then
      fltParAntPFisica := fltValor
    Else If qryAux.FieldValue('CLI_CGCCPF') = 'I' Then
      fltParAntIndustria := fltValor
    Else If qryAux.FieldValue('CLI_CGCCPF') = 'A' Then
      fltParAntAutonomo := fltValor;

    qryAux.Next;
  End;
end;

procedure TfraComparativo.pCarregaParticipacaoPessoaAnoAtual;
var
  fltValor,
  fltMaior: Double;
  intPerMax: Integer;
begin
  lblParticipacaoPessoaAnoAtual.Text := IntToStr(intAnoAtu);

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteDtaIni, dteDtaFin, trValorVenda, taTipoPessoa, strCodDeptoUsuarioLogado);
  qryAux.Open;

  fltMaior := 0.00;
  fltValorTotalParAtu := 0.00;

  qryAux.First;
  While Not qryAux.Eof Do
  Begin
    If qryAux.FieldValue('VALOR') <> null Then
    Begin
      If qryAux.FieldValue('VALOR') > fltMaior Then
        fltMaior := qryAux.FieldValue('VALOR');

      fltValorTotalParAtu := fltValorTotalParAtu + qryAux.FieldValue('VALOR');
    End;
    qryAux.Next;
  End;

  intPerMax := Round((fltMaior / fltValorTotalParAtu) * 100);
  If intPerMax > intPerMaxPartPes Then
    intPerMaxPartPes := intPerMax;

  qryAux.First;

  While Not qryAux.Eof Do
  Begin
    fltValor := 0.0;
    If qryAux.FieldValue('VALOR') <> null Then
      fltValor := qryAux.FieldValue('VALOR');

    If qryAux.FieldValue('CLI_CGCCPF') = 'J' Then
      fltParAtuPJuridica := fltValor
    Else If qryAux.FieldValue('CLI_CGCCPF') = 'F' Then
      fltParAtuPFisica := fltValor
    Else If qryAux.FieldValue('CLI_CGCCPF') = 'I' Then
      fltParAtuIndustria := fltValor
    Else If qryAux.FieldValue('CLI_CGCCPF') = 'A' Then
      fltParAtuAutonomo := fltValor;

    qryAux.Next;
  End;
end;

procedure TfraComparativo.pCarregaParticipacaoPessoaUltimos3Meses;
var
  fltValor,
  fltMaior: Double;
  intPerMax: Integer;
begin
  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(DataAntIni, DataAntFin, trValorVenda, taTipoPessoa, strCodDeptoUsuarioLogado);
  qryAux.Open;

  fltMaior := 0.00;
  fltValorTotalParU3M := 0.00;

  qryAux.First;
  While Not qryAux.Eof Do
  Begin
    If qryAux.FieldValue('VALOR') <> null Then
    Begin
      If qryAux.FieldValue('VALOR') > fltMaior Then
        fltMaior := qryAux.FieldValue('VALOR');

      fltValorTotalParU3M := fltValorTotalParU3M + qryAux.FieldValue('VALOR');
    End;
    qryAux.Next;
  End;

  intPerMax := Round((fltMaior / fltValorTotalParU3M) * 100);
  If intPerMax > intPerMaxPartPes Then
    intPerMaxPartPes := intPerMax;

  qryAux.First;

  While Not qryAux.Eof Do
  Begin
    fltValor := 0.0;
    If qryAux.FieldValue('VALOR') <> null Then
      fltValor := qryAux.FieldValue('VALOR');

    If qryAux.FieldValue('CLI_CGCCPF') = 'J' Then
      fltParU3MPJuridica := fltValor
    Else If qryAux.FieldValue('CLI_CGCCPF') = 'F' Then
      fltParU3MPFisica := fltValor
    Else If qryAux.FieldValue('CLI_CGCCPF') = 'I' Then
      fltParU3MIndustria := fltValor
    Else If qryAux.FieldValue('CLI_CGCCPF') = 'A' Then
      fltParU3MAutonomo := fltValor;

    qryAux.Next;
  End;
end;

procedure TfraComparativo.pCarregaPositivacao;
var
  intPositAtu, intPositAnt, intPositU3M, intMax: Integer;
  blnAumentou: Boolean;
  extTotalHeight: Extended;
begin
  lblAnoPositivacaoAtu.Text := IntToStr(intAnoAtu);
  lblAnoPositivacaoAnt.Text := IntToStr(intAnoAnt);

  intPositAtu := fQtdClientesPositivados(dteDtaIni, dteDtaFin, strCodDeptoUsuarioLogado);
  intMax := intPositAtu;

  intPositAnt := fQtdClientesPositivados(dteAntIni, dteAntFin, strCodDeptoUsuarioLogado);
  If intPositAnt > intMax Then
    intMax := intPositAnt;

  intPositU3M := fQtdClientesPositivados(DataAntIni, DataAntFin, strCodDeptoUsuarioLogado);
  If intPositU3M > intMax Then
    intMax := intPositU3M;

  blnAumentou := intPositAtu >= intPositAnt;

  intMax := ((intMax div 4) + 1) * 4;

  lblPositiv2.Text := IntToStr(intMax div 4);
  lblPositiv3.Text := IntToStr(intMax div 2);
  lblPositiv4.Text := IntToStr((intMax div 4) * 3);
  lblPositiv5.Text := IntToStr(intMax);

  extTotalHeight := linPositivBotton.Position.Y - linPositivTop.Position.Y;

  anmPositvAntHeigth.StopValue := intPositAnt * extTotalHeight / intMax;
  anmPositvAntTop.StopValue := linPositivBotton.Position.Y - anmPositvAntHeigth.StopValue;
  anmPositvAtuHeigth.StopValue := intPositAtu * extTotalHeight / intMax;
  anmPositvAtuTop.StopValue := linPositivBotton.Position.Y - anmPositvAtuHeigth.StopValue;
  anmPositvMesHeigth.StopValue := intPositU3M * extTotalHeight / intMax;
  anmPositvMesTop.StopValue := linPositivBotton.Position.Y - anmPositvMesHeigth.StopValue;

  lblPositivacaoAnt.Position.Y := anmPositvAntTop.StopValue - lblPositivacaoAnt.Height;
  lblPositivacaoAtu.Position.Y := anmPositvAtuTop.StopValue - lblPositivacaoAtu.Height;
  lblPositivacaoUltimos3meses.Position.Y := anmPositvMesTop.StopValue - lblPositivacaoUltimos3meses.Height;
  lblPositivacaoAnt.Text := IntToStr(intPositAnt);
  lblPositivacaoAtu.Text := IntToStr(intPositAtu);
  lblPositivacaoUltimos3meses.Text := IntToStr(intPositU3M);
  lblVariacaoPositivacao.Text := IntToStr(intPositAtu - intPositAnt);

  if Not blnAumentou Then
  Begin
    pthPositivacao.RotationAngle := 180;
    pthPositivacao.Fill.Color := $FFC56C6C;
  End;
end;

procedure TfraComparativo.pCarregaQuantidadesVenda;
var
  intAcumuladoAtu, intAcumuladoAnt, intDiferenca: Integer;
  intDia, intUltimoDia: Integer;
  fltAcumuladoU3M: Double;
begin
  lblTituloQuantidadeVendas.Text := 'Quantidade de Tickets - Comparativo mês de ' + fMesComp(intMes);
  lblLegAnoAtu2.Text := IntToStr(intAnoAtu);
  lblLegAnoAnt2.Text := IntToStr(intAnoAnt);

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteDtaIni, dteDtaFin, trContagem, taData, strCodDeptoUsuarioLogado);
  qryAux.Open;

  serTicketAnoAtu.Clear;
  qryAux.First;
  intAcumuladoAtu := 0;
  intDia := 1;
  intUltimoDia := 1;
  While Not qryAux.Eof Do
  begin
    while qryAux.FieldValue('DIAMES') > intDia Do
    Begin
      serTicketAnoAtu.Add(intAcumuladoAtu, IntToStr(intDia));
      Inc(intDia);
    End;

    If qryAux.FieldValue('VALOR') <> null Then
      intAcumuladoAtu := intAcumuladoAtu + qryAux.FieldValue('VALOR');
    serTicketAnoAtu.Add(intAcumuladoAtu, IntToStr(intDia));
    qryAux.Next;
    intUltimoDia := intDia;
    Inc(intDia);
  end;
  While intUltimoDia < StrToInt(FormatDateTime('dd', dteHoje)) Do
  Begin
    serTicketAnoAtu.Add(intAcumuladoAtu, IntToStr(intUltimoDia));
    Inc(intUltimoDia);
  End;
  lblAnoAtuTickets.Text := IntToStr(intAcumuladoAtu);
  intQtdAtu := intAcumuladoAtu;

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteAntIni, dteAntFin, trContagem, taData, strCodDeptoUsuarioLogado);
  qryAux.Open;

  serTicketAnoAnt.Clear;
  qryAux.First;
  intAcumuladoAnt := 0;
  intDia := 1;
  While Not qryAux.Eof Do
  begin
    while qryAux.FieldValue('DIAMES') > intDia Do
    Begin
      serTicketAnoAnt.Add(intAcumuladoAnt, IntToStr(intDia));
      if intDia = intUltimoDia Then
        intQtdAnt := intAcumuladoAnt;

      Inc(intDia);
    End;

    If qryAux.FieldValue('VALOR') <> null Then
      intAcumuladoAnt := intAcumuladoAnt + qryAux.FieldValue('VALOR');
    serTicketAnoAnt.Add(intAcumuladoAnt, IntToStr(intDia));
    if intDia = intUltimoDia Then
      intQtdAnt := intAcumuladoAnt;

    qryAux.Next;
    Inc(intDia);
  end;
  While intDia < StrToInt(FormatDateTime('dd', dteAntFin)) Do
  Begin
    serTicketAnoAnt.Add(intAcumuladoAnt, IntToStr(intDia));
    Inc(intDia);
  End;

  {Últimos 3 Meses}
  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(DataAntIni, DataAntFin, trContagem, taMediaDia, strCodDeptoUsuarioLogado);
  qryAux.Open;

  serTicketU3M.Clear;
  qryAux.First;
  fltAcumuladoU3M := 0;
  intDia := 1;
  While Not qryAux.Eof Do
  begin
    If qryAux.FieldValue('VALOR') <> null Then
      fltAcumuladoU3M := fltAcumuladoU3M + qryAux.FieldValue('VALOR');

    serTicketU3M.Add(fltAcumuladoU3M, IntToStr(intDia));

    if intDia = intUltimoDia Then
      fltQtdU3M := fltAcumuladoU3M;

    qryAux.Next;
    Inc(intDia);
  end;

  lblHojeAnoAntTickets.Text := IntToStr(intQtdAnt);
  intDiferenca := intAcumuladoAtu - intQtdAnt;
  lblDiferencaTickets.Text := IntToStr(intDiferenca);
  If intQtdAnt > 0 Then
    lblDiferencaTickets.Text := lblDiferencaTickets.Text + '     ' + FormatFloat('0', intDiferenca  * 100 / intQtdAnt) + '%';
  lblAnoAntTickets.Text := IntToStr(intAcumuladoAnt);
  lblHojeAnoAntTicketsDesc.Text  := 'Total até ' + IntToStr(intUltimoDia) + ' de ' + fMesComp(intMes) + ' de ' + lblLegAnoAnt2.Text;

  If intDiferenca < 0 Then
    lblDiferencaTickets.FontColor := $FFC56C6C
  Else
    lblDiferencaTickets.FontColor := $FF60B1CC;
end;

procedure TfraComparativo.pCarregaValoresVenda;
var
  fltAcumuladoAtu, fltAcumuladoAnt, fltAcumuladoU3M, fltDiferenca: Double;
  intDia, intUltimoDia: Integer;
begin
  lblTituloValorVendas.Text := 'Valor de Vendas - Comparativo mês de ' + fMesComp(intMes);
  lblLegAnoAtu.Text := IntToStr(intAnoAtu);
  lblLegAnoAnt.Text := IntToStr(intAnoAnt);

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteDtaIni, dteDtaFin, trValorVenda, taData, strCodDeptoUsuarioLogado);
  qryAux.Open;

  serAnoAtual.Clear;
  qryAux.First;
  fltAcumuladoAtu := 0.0;
  intDia := 1;
  intUltimoDia := 1;
  While Not qryAux.Eof Do
  begin
    while qryAux.FieldValue('DIAMES') > intDia Do
    Begin
      serAnoAtual.Add(fltAcumuladoAtu, IntToStr(intDia));
      Inc(intDia);
    End;

    If qryAux.FieldValue('VALOR') <> null Then
      fltAcumuladoAtu := fltAcumuladoAtu + qryAux.FieldValue('VALOR');
    serAnoAtual.Add(fltAcumuladoAtu, IntToStr(intDia));
    qryAux.Next;
    intUltimoDia := intDia;
    Inc(intDia);
  end;
  While intUltimoDia < StrToInt(FormatDateTime('dd', dteHoje)) Do
  Begin
    Inc(intUltimoDia);
    serAnoAtual.Add(fltAcumuladoAtu, IntToStr(intUltimoDia));
  End;
  lblAnoAtuTotal.Text := 'R$ ' + FormatFloat('#,##0.00', fltAcumuladoAtu);
  fltValAtu := fltAcumuladoAtu;

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteAntIni, dteAntFin, trValorVenda, taData, strCodDeptoUsuarioLogado);
  qryAux.Open;

  serAnoAnterior.Clear;
  qryAux.First;
  fltAcumuladoAnt := 0.0;
  intDia := 1;
  While Not qryAux.Eof Do
  begin
    while qryAux.FieldValue('DIAMES') > intDia Do
    Begin
      serAnoAnterior.Add(fltAcumuladoAnt, IntToStr(intDia));
      if intDia = intUltimoDia Then
        fltValAnt := fltAcumuladoAnt;

      Inc(intDia);
    End;

    If qryAux.FieldValue('VALOR') <> null Then
      fltAcumuladoAnt := fltAcumuladoAnt + qryAux.FieldValue('VALOR');
    serAnoAnterior.Add(fltAcumuladoAnt, IntToStr(intDia));

    if intDia = intUltimoDia Then
      fltValAnt := fltAcumuladoAnt;

    qryAux.Next;
    Inc(intDia);
  end;
  While intDia < StrToInt(FormatDateTime('dd', dteAntFin)) Do
  Begin
    serAnoAnterior.Add(fltAcumuladoAnt, IntToStr(intDia));
    Inc(intDia);
  End;

  {Últimos 3 Meses}
  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(DataAntIni, DataAntFin, trValorVenda, taMediaDia, strCodDeptoUsuarioLogado);
  qryAux.Open;

  serUltimos3M.Clear;
  qryAux.First;
  fltAcumuladoU3M := 0.0;
  intDia := 1;
  While Not qryAux.Eof Do
  begin
    while qryAux.FieldValue('DIAMES') > intDia Do
    Begin
      serUltimos3M.Add(fltAcumuladoU3M, IntToStr(intDia));
      if intDia = intUltimoDia Then
        fltValU3M := fltAcumuladoU3M;

      Inc(intDia);
    End;

    If qryAux.FieldValue('VALOR') <> null Then
      fltAcumuladoU3M := fltAcumuladoU3M + qryAux.FieldValue('VALOR');
    serUltimos3M.Add(fltAcumuladoU3M, IntToStr(intDia));

    if intDia = intUltimoDia Then
      fltValU3M := fltAcumuladoU3M;

    qryAux.Next;
    Inc(intDia);
  end;
  While intDia < StrToInt(FormatDateTime('dd', dteHoje)) Do
  Begin
    serUltimos3M.Add(fltAcumuladoU3M, IntToStr(intDia));
    Inc(intDia);
  End;

  lblHojeAnoAntTotal.Text := 'R$ ' + FormatFloat('#,##0.00', fltValAnt);
  fltDiferenca := fltAcumuladoAtu - fltValAnt;
  lblDiferencaValor.Text := 'R$ ' + FormatFloat('#,##0.00', fltDiferenca);
  If fltValAnt > 0 Then
    lblDiferencaPercent.Text := FormatFloat('0', fltDiferenca  * 100 / fltValAnt) + '%'
  Else
    lblDiferencaPercent.Text := '';
  lblAnoAntTotal.Text := 'R$ ' + FormatFloat('#,##0.00', fltAcumuladoAnt);
  lblHojeAnoAntTotalDesc.Text  := 'Total até ' + IntToStr(intUltimoDia) + ' de ' + fMesComp(intMes) + ' de ' + lblLegAnoAnt.Text;

  If fltDiferenca < 0 Then
    lblDiferencaValor.FontColor := $FFC56C6C
  Else
    lblDiferencaValor.FontColor := $FF60B1CC;
  lblDiferencaPercent.FontColor := lblDiferencaValor.FontColor;
end;

procedure TfraComparativo.pCarregaValorMedioVenda;
begin
  If intQtdAnt > 0 Then
    lblValorMedioAnt.Text := 'R$ ' + FormatFloat('#,##0.00', fltValAnt / intQtdAnt)
  Else
    lblValorMedioAnt.Text := 'R$ 0,00';
  lblValorMedioAntDesc.Text := 'Valor médio por ticket em ' + IntToStr(intAnoAnt);
  If intQtdAtu > 0 Then
    lblValorMedioAtu.Text := 'R$ ' + FormatFloat('#,##0.00', fltValAtu / intQtdAtu)
  Else
    lblValorMedioAtu.Text := 'R$ 0,00';
  lblValorMedioAtuDesc.Text := 'Valor médio por ticket em ' + IntToStr(intAnoAtu);

  If fltQtdU3M > 0 Then
    lblValorMedioU3M.Text := 'R$ ' + FormatFloat('#,##0.00', fltValU3M / fltQtdU3M)
  Else
    lblValorMedioU3M.Text := 'R$ 0,00';
end;

procedure TfraComparativo.anmPartAntAPrazoHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAntAPrazo.Visible := True;
end;

procedure TfraComparativo.anmPartAntAVistaHeightFinish(Sender: TObject);
begin
  inherited;
  lblParAntAVista.Visible := True;
end;

procedure TfraComparativo.serTicketClickPointer(Sender: TCustomSeries;
  ValueIndex, X, Y: Integer);
begin
  inherited;
  With recValorTickets Do
  Begin
    Visible    := False;
    Position.X := X-53;
    Position.Y := Y-12;

    lblValorTickets.Text := Sender.ValueMarkText[ValueIndex];

    Visible := True;

    If (Sender = serTicketAnoAnt) Then
    Begin
      lblDataTickets.Text := Copy(Sender.XLabel[ValueIndex],1,2) + ' ' +
                        fMes(intMes) + ' ' +
                        lblLegAnoAnt2.Text;
    End
    Else If (Sender = serTicketAnoAtu) Then
    Begin
      lblDataTickets.Text := Copy(Sender.XLabel[ValueIndex],1,2) + ' ' +
                        fMes(intMes) + ' ' +
                        lblLegAnoAtu2.Text;
    End
    Else If (Sender = serTicketU3M) Then
    Begin
      lblDataTickets.Text := Copy(Sender.XLabel[ValueIndex],1,2) + ' ' +
                        fMes(MonthOfTheYear(DataAntIni)) + ' - ' + fMes(MonthOfTheYear(DataAntFin)) + ' ' +
                        lblLegAnoAtu2.Text;
    End;

    cirCorTickets.Fill.Color := Sender.SeriesColor;
  End;
end;

procedure TfraComparativo.serValorClickPointer(Sender: TCustomSeries;
  ValueIndex, X, Y: Integer);
begin
  With calValorVendas Do
  Begin
    Visible    := False;
    Position.X := X-54;
    Position.Y := Y-12;

    lblValorVendas.Text := 'R$ ' + FormatFloat('#,##0.00', fStrToFloat(Sender.ValueMarkText[ValueIndex]));

    Visible := True;

    If (Sender = serAnoAnterior) Then
    Begin
      lblDataVendas.Text := Copy(Sender.XLabel[ValueIndex],1,2) + ' ' +
                        fMes(intMes) + ' ' +
                        lblLegAnoAnt.Text;
    End
    Else If (Sender = serAnoAtual) Then
    Begin
      lblDataVendas.Text := Copy(Sender.XLabel[ValueIndex],1,2) + ' ' +
                        fMes(intMes) + ' ' +
                        lblLegAnoAtu.Text;
    End
    Else If (Sender = serUltimos3M) Then
    Begin
      lblDataVendas.Text := Copy(Sender.XLabel[ValueIndex],1,2) + ' ' +
                        fMes(MonthOfTheYear(DataAntIni)) + ' - ' + fMes(MonthOfTheYear(DataAntFin)) + ' ' +
                        lblLegAnoAtu.Text;
    End;

    cirCorVendas.Fill.Color := Sender.SeriesColor;
  End;
end;

end.
