unit untMostrarTotalPorUnidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, UniClientDataSet,
  BitBtnLockedIncrem, Datasnap.DBClient, Uni, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxCurrencyEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxTextEdit;

type
  TUnidade = record
    PesLit: Double;
    DesUni: String;
  end;

  TfrmMostrarTotalPorUnidade = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    dtsLitrag: TDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    lblTotalKG: TLabel;
    lblTotalLT: TLabel;
    cxGrid1DBTableView1UNI_KILLIT: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    cdsExibicao: TUniClientDataSet;
    qryConsultaCadUni: TUniQuery;
    FTotalLT, FTotalKG: Double;

    function pPrepararCdsExibicao: boolean;
    procedure pMontarEstruturaCDSExibicao;
    function pPopularCdsExibicao: boolean;
    procedure pCancelar;
    function fLocalizarUnidade(CodUni: string): Boolean;
    { Private declarations }
  public
    cdsItensPedido: TUniClientDataSet;
    { Public declarations }
  end;

var
  frmMostrarTotalPorUnidade: TfrmMostrarTotalPorUnidade;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmMostrarTotalPorUnidade.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmMostrarTotalPorUnidade.fLocalizarUnidade(CodUni: string): Boolean;

begin
  If not Assigned(qryConsultaCadUni) Then
  Begin
    qryConsultaCadUni := fCriaQuery;
    qryConsultaCadUni.SQL.Add('SELECT * FROM CADUNI');
    qryConsultaCadUni.Open;
  End;
  Try
    If CodUni = '' Then
      Result := False
    Else
      Result := qryConsultaCadUni.Locate('UNI_CODUNI', CodUni, [loCaseInsensitive]);
  Except
    Result := False;
  End;
end;

procedure TfrmMostrarTotalPorUnidade.FormDestroy(Sender: TObject);
begin
  cdsItensPedido.EnableControls;

  If Assigned(qryConsultaCadUni) Then
     FreeAndNil(qryConsultaCadUni);
  If Assigned(cdsExibicao) Then
     FreeAndNil(cdsExibicao);
  inherited;
end;

procedure TfrmMostrarTotalPorUnidade.FormShow(Sender: TObject);
begin
  pSetFocus(btnFechar);
  If not Assigned(cdsItensPedido) Then
  Begin
    pCancelar;
    Exit;
  End;

  cdsItensPedido.DisableControls;
  cdsItensPedido.First;
  if pPrepararCdsExibicao Then
    dtsLitrag.DataSet := cdsExibicao
  Else
    pCancelar;

  inherited;
end;

procedure TfrmMostrarTotalPorUnidade.pCancelar;
begin
  ModalResult := mrAbort;
  Close;
end;

procedure TfrmMostrarTotalPorUnidade.pMontarEstruturaCDSExibicao;
begin
  With cdsExibicao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_SIGUNI';
    DataType := ftString;
    Size := 6;
  End;

  With cdsExibicao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESUNI';
    DataType := ftString;
    Size := 70;
  End;

  With cdsExibicao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_QTDITE';
    DataType := ftFloat;
  End;

  With cdsExibicao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_PESLIT';
    DataType := ftFloat;
  End;

  With cdsExibicao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CODUNI';
    DataType := ftString;
  End;

  With cdsExibicao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNI_KILLIT';
    DataType := ftString;
  End;

  cdsExibicao.CreateDataSet;
  cdsExibicao.IndexFieldNames := 'ITE_SIGUNI';
end;

function TfrmMostrarTotalPorUnidade.pPopularCdsExibicao: boolean;
begin
  Try
    cdsItensPedido.First;
    //Ja faz o calculo somatorio quando a sigla estiver insirida
    While not cdsItensPedido.Eof Do
    Begin
      If cdsExibicao.Locate('ITE_CODUNI', cdsItensPedido.FieldByName('ITE_CODUNI').Value, []) Then
        cdsExibicao.Edit
      Else
      Begin
        cdsExibicao.Insert;
        cdsExibicao.FieldByName('ITE_SIGUNI').Value := cdsItensPedido.FieldByName('ITE_SIGUNI').Value;
        cdsExibicao.FieldByName('ITE_CODUNI').Value := cdsItensPedido.FieldByName('ITE_CODUNI').Value;
        If fLocalizarUnidade(cdsItensPedido.FieldByName('ITE_CODUNI').AsString) Then
        begin
          cdsExibicao.FieldByName('ITE_DESUNI').Value := qryConsultaCadUni.FieldByName('UNI_DESUNI').AsString;


          if qryConsultaCadUni.FieldByName('UNI_KILLIT').AsString = 'L' then
            cdsExibicao.FieldByName('UNI_KILLIT').Value := 'LT';

          if qryConsultaCadUni.FieldByName('UNI_KILLIT').AsString = 'K' then
            cdsExibicao.FieldByName('UNI_KILLIT').Value := 'KG';

        end;

      End;
      cdsExibicao.FieldByName('ITE_QTDITE').Value := cdsExibicao.FieldByName('ITE_QTDITE').AsFloat + cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;
      cdsExibicao.FieldByName('ITE_PESLIT').Value := cdsExibicao.FieldByName('ITE_PESLIT').AsFloat + cdsItensPedido.FieldByName('ITE_LITROS').AsFloat;

      if cdsExibicao.FieldByName('UNI_KILLIT').AsString = 'LT' then
        FTotalLT := FTotalLT+cdsItensPedido.FieldByName('ITE_LITROS').AsFloat;

      if cdsExibicao.FieldByName('UNI_KILLIT').AsString = 'KG' then
        FTotalKG := FTotalKG+cdsItensPedido.FieldByName('ITE_LITROS').AsFloat;

      cdsExibicao.Post;

      cdsItensPedido.Next;
    End;
    Result := True;
    lblTotalKG.Caption := 'Total KG: '+FormatFloat('#0.00',FTotalKG);
    lblTotalLT.Caption := 'Total LT: '+FormatFloat('#0.00',FTotalLT);
  Except
    Result := False;
  End;
end;

function TfrmMostrarTotalPorUnidade.pPrepararCdsExibicao: boolean;
begin
  Try
    cdsExibicao := TUniClientDataSet.Create(Self);
    pMontarEstruturaCDSExibicao;
    Result := pPopularCdsExibicao;
  Except
    Result := False;
  End;
end;

end.


