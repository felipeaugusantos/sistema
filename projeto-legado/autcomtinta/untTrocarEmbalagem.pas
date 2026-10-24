unit untTrocarEmbalagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet,
  Uni,  BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmTrocarEmbalagem = class(TfrmPai)
    pnlGeral: TPanel;
    cxgEmbalagensDBTableView1: TcxGridDBTableView;
    cxgEmbalagensLevel1: TcxGridLevel;
    cxgEmbalagens: TcxGrid;
    dtsEmbalagens: TDataSource;
    cdsEmbalagens: TUniClientDataSet;
    cdsEmbalagensCODITE: TStringField;
    cdsEmbalagensDESITE: TStringField;
    cdsEmbalagensPRINCI: TStringField;
    cxgEmbalagensDBTableView1CODITE: TcxGridDBColumn;
    cxgEmbalagensDBTableView1DESITE: TcxGridDBColumn;
    cxgEmbalagensDBTableView1PRINCI: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsEmbalagensAfterScroll(DataSet: TDataSet);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    strEmbala: String;
    strLinha_: String;

    procedure pBuscaProdutosEmbalagens;
  public
    { Public declarations }
    //Variavel usada como retorno
    strCodIte: String;

    procedure pSetaParametros(strEmbalaEmb, strLinha_Emb: String);
  end;

var
  frmTrocarEmbalagem: TfrmTrocarEmbalagem;

implementation
uses untFuncoesSimples;
{$R *.dfm}

procedure TfrmTrocarEmbalagem.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  strCodIte := cdsEmbalagensCODITE.AsString;
end;

procedure TfrmTrocarEmbalagem.cdsEmbalagensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnConfirma.Enabled := Not cdsEmbalagens.IsEmpty;
end;

procedure TfrmTrocarEmbalagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not cdsEmbalagens.IsEmpty Then
    cdsEmbalagens.EmptyDataSet;
end;

procedure TfrmTrocarEmbalagem.FormCreate(Sender: TObject);
begin
  inherited;
  cdsEmbalagens.CreateDataSet;
  strCodIte := '';
end;

procedure TfrmTrocarEmbalagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10:btnConfirma.Click;
  End;
end;

procedure TfrmTrocarEmbalagem.FormShow(Sender: TObject);
begin
  inherited;
  pBuscaProdutosEmbalagens;
end;

procedure TfrmTrocarEmbalagem.pBuscaProdutosEmbalagens;
var
  qryCon: TUniQuery;
begin
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT CFG_CODITE, ');
        SQL.Add('        ITE_DESITE, ');
        SQL.Add('        CFG_PRINCI  ');
        SQL.Add('   FROM CFGEMB      ');
        SQL.Add('  INNER JOIN CADITE ON ITE_CODITE = CFG_CODITE ');
        SQL.Add('                   AND ITE_CODEMP = CFG_CODEMP ');
        SQL.Add('  WHERE CFG_EMBALA = :EMBALA ');
        SQL.Add('    AND CFG_LINHA_ = :LINHA_ ');
        SQL.Add('    AND CFG_CODEMP = :CODEMP ');
        SQL.Add('  ORDER BY CFG_PRINCI        ');
        ParamByName('EMBALA').AsString := strEmbala;
        ParamByName('LINHA_').AsString := strLinha_;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;
        If Not IsEmpty then
        Begin
          First;
          While Not Eof Do
          Begin
            cdsEmbalagens.Append;
            cdsEmbalagensCODITE.AsString := FieldByName('CFG_CODITE').AsString;
            cdsEmbalagensDESITE.AsString := FieldByName('ITE_DESITE').AsString;
            cdsEmbalagensPRINCI.AsString := FieldByName('CFG_PRINCI').AsString;
            cdsEmbalagens.Post;

            Next;
          End;
          pSetFocus(cxgEmbalagens);
        End;
      End;
    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO','Erro ao consultar produtos embalagens cadastrados!',['&O K']);
      end;
    End;
  Finally
    FreeAndNil(qryCon);
  End;                            
end;

procedure TfrmTrocarEmbalagem.pSetaParametros(strEmbalaEmb,
  strLinha_Emb: String);
begin
  strEmbala := strEmbalaEmb;
  If Pos('DELTRON', strLinha_Emb) > 0 Then
    strLinha_ := 'DELTRON(LA)'
  Else
    strLinha_ := strLinha_Emb;  
end;

end.

