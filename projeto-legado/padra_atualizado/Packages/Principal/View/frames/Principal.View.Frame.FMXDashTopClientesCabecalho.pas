unit Principal.View.Frame.FMXDashTopClientesCabecalho;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Controls.Presentation, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, Shared.Functions.DataSet,
  Shared.Functions.Core;

type
  TframeTopClientesCabecalho = class(TfraGraficoBase)
    layTopClientes: TLayout;
    layCentralizarTopClientes: TLayout;
    layTopoTopClientes: TLayout;
    lblLegendaVenda: TLabel;
    recLegendaVenda: TRectangle;
    lblLegendaMargem: TLabel;
    recLegendaMargem: TRectangle;
    lstFramesTopClientes: TListBox;
    lstiteRegistros: TListBoxItem;
    layRodapeTopClientes: TLayout;
    linRodape: TLine;
    lblTitulo: TLabel;
  private
    { Private declarations }
    procedure AtualizaValoresTopClientes(strCodEmp: String);
  public
    { Public declarations }
    procedure AtualizaTopClientes(dtaSelecionado:TDateTime; strTipEmp, strCodEmp: String);
  end;

var
  frameTopClientesCabecalho: TframeTopClientesCabecalho;

implementation

uses
  Principal.View.Frame.FMXDashTopClientesLinha;

{$R *.fmx}

{ TframeConstrucaoMeta2 }

procedure TframeTopClientesCabecalho.AtualizaTopClientes(dtaSelecionado:TDateTime; strTipEmp, strCodEmp: String);
begin
  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  AnimarAguarde(layTopClientes);
  AtualizaValoresTopClientes(strCodEmp);
  AnimarAguarde(layTopClientes, False);
end;

procedure TframeTopClientesCabecalho.AtualizaValoresTopClientes(strCodEmp: String);
Var
  qryTop : IMyQuery;
  strSQL : String;
  LItem  : TListBoxItem;
  LFrame : TframeTopClientesLinha;
  LCount : Integer;
begin
  strSQL := objDash.RetornaSQLTopClientes(dtaMesSelecionado, strTipoEmpresa, strCodEmp);

  If Not strSQL.IsEmpty Then
  Begin
    lstFramesTopClientes.Items.Clear;

    Try
      lstFramesTopClientes.BeginUpdate;
      qryTop := objCore.fCriarQuery;

      qryTop.Close;
      qryTop.SQL.Clear;
      qryTop.SQL.Add(strSQL);
      qryTop.Open;

      If Not qryTop.IsEmpty Then
      Begin
        lstFramesTopClientes.Items.Clear;

        While Not qryTop.Eof Do
        Begin
          Inc(LCount);
          Application.ProcessMessages;

          LItem := TListBoxItem.Create(Self);
          LFrame:= TframeTopClientesLinha.Create(Self);
          LFrame.Name := 'Frame' + LCount.ToString();

          LFrame.Parent := LItem;
          LFrame.Align  := TAlignLayout.Client;
          LItem.Height  := 40;

          LFrame.lblDescricao.Text   := qryTop.FieldByName('CLIENTE').AsString;
          LFrame.lblValorVenda.Text  := 'R$ ' + FormatFloat('#,##0.00', qryTop.FieldByName('TOTITE').AsFloat);
          LFrame.lblValorMargem.Text := FormatFloat('#,##0.00', qryTop.FieldByName('MARGEM').AsFloat) + '%';

          LItem.Parent := lstFramesTopClientes;
          qryTop.Next;
        End;

        Self.Height := 45 + (qryTop.RecordCount * 40);
        linRodape.Margins.Left := Self.Width - 316;
      End;

    Finally
      lstFramesTopClientes.EndUpdate;
    End;
  End;
end;

end.
