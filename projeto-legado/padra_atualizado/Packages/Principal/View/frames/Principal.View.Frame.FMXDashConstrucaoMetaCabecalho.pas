unit Principal.View.Frame.FMXDashConstrucaoMetaCabecalho;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Controls.Presentation, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, Shared.Functions.DataSet,
  Shared.Functions.Core;

type
  TframeConstrucaoMeta = class(TfraGraficoBase)
    layConstrucaoMeta: TLayout;
    layCentralizarConstrucaoMeta: TLayout;
    layGruposConstrucaoMeta: TLayout;
    lblLegendaMesCorrente: TLabel;
    recLegendaMesCorrente: TRectangle;
    lblLegendaUltimosMeses: TLabel;
    recLegendaUltimosMeses: TRectangle;
    lblEspacoGrupos: TLabel;
    layColunasConstrucaoMeta: TLayout;
    layColunasMesCorrente: TLayout;
    lblTicketMedioMesCorrente: TLabel;
    lblValorMesCorrente: TLabel;
    lblQtdeMesCorrente: TLabel;
    recFundoColunasMesCorrente: TRectangle;
    layColunasUltimosMeses: TLayout;
    lblTicketMedioUltimosMeses: TLabel;
    lblValorUltimosMeses: TLabel;
    lblQtdeUltimosMeses: TLabel;
    recFundoColunasUltimosMeses: TRectangle;
    recFundoColunasConstrucaoMeta: TRectangle;
    lstFramesConstrucaoMeta: TListBox;
    lstiteRegistros: TListBoxItem;
    layRodapeConstrucaoMeta: TLayout;
    linRodape: TLine;
    Label1: TLabel;
  private
    { Private declarations }
    procedure AtualizaValoresConstrucaoMeta(strCodEmp: String);
  public
    { Public declarations }
    procedure AtualizaConstrucaoMeta(dtaSelecionado:TDateTime; strTipEmp, strCodEmp: String);
  end;

var
  frameConstrucaoMeta: TframeConstrucaoMeta;

implementation

uses
  Principal.View.Frame.FMXDashConstrucaoMetaLinha;

{$R *.fmx}

{ TframeConstrucaoMeta2 }

procedure TframeConstrucaoMeta.AtualizaConstrucaoMeta(dtaSelecionado:TDateTime; strTipEmp, strCodEmp: String);
begin
  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  AnimarAguarde(layCentralizarConstrucaoMeta);
  AtualizaValoresConstrucaoMeta(strCodEmp);
  AnimarAguarde(layCentralizarConstrucaoMeta, False);
end;

procedure TframeConstrucaoMeta.AtualizaValoresConstrucaoMeta(strCodEmp: String);
Var
  qryMeta: IMyQuery;
  strSQL : String;
  LItem  : TListBoxItem;
  LFrame : TframeConstrucaoMetaLinha;
  LCount : Integer;
begin
  strSQL := objDash.RetornaSQLConstrucaoMeta(dtaMesSelecionado, strTipoEmpresa, strCodEmp);

  If Not strSQL.IsEmpty Then
  Begin
    Try
      lstFramesConstrucaoMeta.BeginUpdate;
      qryMeta := objCore.fCriarQuery;

      qryMeta.Close;
      qryMeta.SQL.Clear;
      qryMeta.SQL.Add(strSQL);
      qryMeta.Open;

      If Not qryMeta.IsEmpty Then
      Begin
        lstFramesConstrucaoMeta.Items.Clear;

        While Not qryMeta.Eof Do
        Begin
          Inc(LCount);
          Application.ProcessMessages;

          LItem := TListBoxItem.Create(Self);
          LFrame:= TframeConstrucaoMetaLinha.Create(Self);
          LFrame.Name := 'Frame' + LCount.ToString();

          LFrame.Parent := LItem;
          LFrame.Align  := TAlignLayout.Client;
          LItem.Height  := 40;

          LFrame.lblDescricao.Text       := qryMeta.FieldByName('Descrição').AsString;

          {* Mês Corrente *}
          LFrame.MostrarBarraDeProgresso(LFrame.lblProgressQtdeMesCorrente, qryMeta.FieldByName('*empty1*').AsString);
          LFrame.MostrarBarraDeProgresso(LFrame.lblProgressValorMesCorrente, qryMeta.FieldByName('*empty2*').AsString);

          LFrame.lblQtdeMesCorrente.Text         := FormataValorEEscondeVazio('#,##0', qryMeta.FieldByName('Quant.').AsString);
          LFrame.lblValorMesCorrente.Text        := FormataValorEEscondeVazio('#,##0.00', qryMeta.FieldByName('Valor').AsString, True);
          LFrame.lblTicketMedioMesCorrente.Text  := FormataValorEEscondeVazio('#,##0.00', qryMeta.FieldByName('Ticket. Médio').AsString, True);

          {* Últimos Meses *}
          LFrame.MostrarBarraDeProgresso(LFrame.lblProgressQtdeUltimosMeses, qryMeta.FieldByName('*empty3*').AsString);
          LFrame.MostrarBarraDeProgresso(LFrame.lblProgressValorUltimosMeses, qryMeta.FieldByName('*empty4*').AsString);

          LFrame.lblQtdeUltimosMeses.Text        := FormataValorEEscondeVazio('#,##0', qryMeta.FieldByName('Quant. 3 Mês').AsString);
          LFrame.lblValorUltimosMeses.Text       := FormataValorEEscondeVazio('#,##0.00', qryMeta.FieldByName('Valor 3 Mês').AsString, True);
          LFrame.lblTicketMedioUltimosMeses.Text := FormataValorEEscondeVazio('#,##0.00', qryMeta.FieldByName('Ticket. Médio 3 Mês').AsString, True);

          LItem.Parent := lstFramesConstrucaoMeta;

          qryMeta.Next;
        End;

        Self.Height := 45 + (qryMeta.RecordCount * 40);
      End;

    Finally
      lstFramesConstrucaoMeta.EndUpdate;
    End;
  End;

end;

end.
