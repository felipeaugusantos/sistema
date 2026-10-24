unit Principal.View.Frame.FMXDashTotalVendedoresCabecalho;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Controls.Presentation, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, Shared.Functions.DataSet,
  Shared.Functions.Core, Principal.View.Frame.FMXDashTotalVendedoresLinha;

type
  TframeTotalVendedores = class(TfraGraficoBase)
    layTotalVendedores: TLayout;
    layCentralizarTotalVendedores: TLayout;
    layGruposTotalVendedores: TLayout;
    lblLegenda: TLabel;
    recLegenda: TRectangle;
    layColunasTotalVendedores: TLayout;
    layColunas: TLayout;
    recFundoColunas: TRectangle;
    lstFramesTotalVendedores: TListBox;
    lstiteRegistros: TListBoxItem;
    layRodapeTotalVendedores: TLayout;
    linRodape: TLine;
    lblPrincipal: TLabel;
    lblValorVendas: TLabel;
    lblValorOrcAbertos: TLabel;
    Line10: TLine;
    lblValorNumVendas: TLabel;
    Line1: TLine;
    lblValorTicketMedio: TLabel;
    Line2: TLine;
    lblValorCliAtendidos: TLabel;
    Line3: TLine;
    lblValorPorRealizado: TLabel;
    Line4: TLine;
    lblValorPorMeta: TLabel;
    Line5: TLine;
    lblValorMeta: TLabel;
    Line6: TLine;
    lblValorProjetado: TLabel;
    Line7: TLine;
    layTotalizacao: TLayout;
    layTotlizacaoColunas: TLayout;
    Rectangle1: TRectangle;
    lblTotVendas: TLabel;
    lblTotOrcAbertos: TLabel;
    Line8: TLine;
    lblTotNumVendas: TLabel;
    Line9: TLine;
    lblTotTicketMedio: TLabel;
    Line11: TLine;
    lblTotCliAtendidos: TLabel;
    Line12: TLine;
    lblTotPorRealizado: TLabel;
    Line13: TLine;
    lblTotPorMeta: TLabel;
    Line14: TLine;
    lblTotMeta: TLabel;
    Line15: TLine;
    lblTotProjetado: TLabel;
    Line16: TLine;
    lblTotalizacao: TLabel;
  private
    { Private declarations }
    procedure AtualizaValoresTotalVendedores(strCodEmp, strTipVis: String);
  public
    { Public declarations }
    procedure AtualizaTotalVendedores(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
  end;

var
  frameTotalVendedores: TframeTotalVendedores;

implementation


{$R *.fmx}

{ TframeConstrucaoMeta2 }

procedure TframeTotalVendedores.AtualizaTotalVendedores(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
begin
  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  AnimarAguarde(layCentralizarTotalVendedores);
  AtualizaValoresTotalVendedores(strCodEmp, strTipVis);
  AnimarAguarde(layCentralizarTotalVendedores, False);
end;

procedure TframeTotalVendedores.AtualizaValoresTotalVendedores(strCodEmp, strTipVis: String);
Var
  qryTot : IMyQuery;
  strSQL : String;
  LItem  : TListBoxItem;
  LFrame : TframeTotalVendedoresLinha;
  LCount : Integer;
  fltTotVenda,
  fltTotMeta,
  fltTotProjet,
  fltTotMetMrg,
  fltTotMrgAtu,
  fltTotCliAtd,
  fltTotNumVen,
  fltTotTckMed,
  fltTotOrcAbe: Double;
begin
  fltTotVenda  := 0;
  fltTotMeta   := 0;
  fltTotProjet := 0;
  fltTotMetMrg := 0;
  fltTotMrgAtu := 0;
  fltTotCliAtd := 0;
  fltTotNumVen := 0;
  fltTotTckMed := 0;
  fltTotOrcAbe := 0;

  strSQL := objDash.RetornaSQLTotalVendedores(dtaMesSelecionado, strTipoEmpresa, strCodEmp, strTipVis);

  If Not strSQL.IsEmpty Then
  Begin
    Try
      lstFramesTotalVendedores.BeginUpdate;
      qryTot := objCore.fCriarQuery;

      qryTot.Close;
      qryTot.SQL.Clear;
      qryTot.SQL.Add(strSQL);
      qryTot.Open;

      If Not qryTot.IsEmpty Then
      Begin
        LCount := 0;
        lstFramesTotalVendedores.Items.Clear;

        While Not qryTot.Eof Do
        Begin
          Inc(LCount);
          Application.ProcessMessages;

          LItem := TListBoxItem.Create(Self);
          LFrame:= TframeTotalVendedoresLinha.Create(Self);
          LFrame.Name := 'Frame' + LCount.ToString();

          LFrame.Parent := LItem;
          LFrame.Align  := TAlignLayout.Contents;
          LItem.Height  := 40;

          LFrame.lblDescricao.Text                 := qryTot.FieldByName('VENDEDORES').AsString;
          LFrame.lblValorTotalVenda.Text           := 'R$ ' + FormatFloat('#,##0.00', qryTot.FieldByName('VENDA').AsFloat);
          LFrame.lblValorMeta.Text                 := 'R$ ' + FormatFloat('#,##0.00', qryTot.FieldByName('META').AsFloat);
          LFrame.lblValorProjetado.Text            := 'R$ ' + FormatFloat('#,##0.00', qryTot.FieldByName('PROJETADO').AsFloat);
          LFrame.lblValorMetaPorcentagem.Text      := FormatFloat('#,##0.00', qryTot.FieldByName('META_MARGEM').AsFloat) + '%';
          LFrame.lblValorRealizadoPorcentagem.Text := FormatFloat('#,##0.00', qryTot.FieldByName('MARGEM_ATUAL').AsFloat) + '%';
          LFrame.lblValorClientesAtendidos.Text    := FormatFloat('#,##0', qryTot.FieldByName('CLI_ATD').AsFloat);
          LFrame.lblValorNumeroVendas.Text         := FormatFloat('#,##0', qryTot.FieldByName('N_VENDAS').AsFloat);
          LFrame.lblValorTicketMedio.Text          := 'R$ ' + FormatFloat('#,##0.00', qryTot.FieldByName('TK_MEDIO').AsFloat);
          LFrame.lblValorOrcamentosAbertos.Text    := 'R$ ' + FormatFloat('#,##0.00', qryTot.FieldByName('OR_ABERTO').AsFloat);

          If (qryTot.RecordCount > 1) Then
          Begin
            fltTotVenda  := fltTotVenda  + qryTot.FieldByName('VENDA').AsFloat;
            fltTotMeta   := fltTotMeta   + qryTot.FieldByName('META').AsFloat;
            fltTotProjet := fltTotProjet + qryTot.FieldByName('PROJETADO').AsFloat;
            fltTotMetMrg := fltTotMetMrg + qryTot.FieldByName('META_MARGEM').AsFloat;
            fltTotMrgAtu := fltTotMrgAtu + qryTot.FieldByName('MARGEM_ATUAL').AsFloat;
            fltTotCliAtd := fltTotCliAtd + qryTot.FieldByName('CLI_ATD').AsFloat;
            fltTotNumVen := fltTotNumVen + qryTot.FieldByName('N_VENDAS').AsFloat;
            fltTotTckMed := fltTotTckMed + qryTot.FieldByName('TK_MEDIO').AsFloat;
            fltTotOrcAbe := fltTotOrcAbe + qryTot.FieldByName('OR_ABERTO').AsFloat;
          End;

          LItem.Parent := lstFramesTotalVendedores;

          qryTot.Next;
        End;
      End;

    Finally
      lstFramesTotalVendedores.EndUpdate;

      If (strTipVis = 'G') Then
      Begin
        Self.Height := 71 + (qryTot.RecordCount * 40);

        lblTotVendas.Text       := 'R$ ' + FormatFloat('#,##0.00', fltTotVenda);
        lblTotMeta.Text         := 'R$ ' + FormatFloat('#,##0.00', fltTotMeta);
        lblTotProjetado.Text    := 'R$ ' + FormatFloat('#,##0.00', fltTotProjet);
        lblTotPorMeta.Text      := FormatFloat('#,##0.00', fltTotMetMrg / qryTot.RecordCount) + '%';
        lblTotPorRealizado.Text := FormatFloat('#,##0.00', fltTotMrgAtu / qryTot.RecordCount) + '%';
        lblTotCliAtendidos.Text := FormatFloat('#,##0', fltTotCliAtd);
        lblTotNumVendas.Text    := FormatFloat('#,##0', fltTotNumVen);
        lblTotTicketMedio.Text  := 'R$ ' + FormatFloat('#,##0.00', fltTotTckMed / qryTot.RecordCount);
        lblTotOrcAbertos.Text   := 'R$ ' + FormatFloat('#,##0.00', fltTotOrcAbe);
      End
      Else
        Self.Height := 85;

      layTotalizacao.Visible := strTipVis = 'G';
      linRodape.Margins.Left := Self.Width - recFundoColunas.Width;
    End;
  End;
end;

end.
