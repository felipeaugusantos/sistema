unit untSelSeparacaoParcial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid;

type
  TfrmSelSeparacaoParcial = class(TfrmPaiConfirma)
    cxGrdSepTableView: TcxGridDBTableViewCitel;
    cxGrdSepLevel: TcxGridLevel;
    cxGrdSep: TcxGridCitel;
    dsSep: TDataSource;
    cxGrdSepTableViewSEQSEP: TcxGridDBColumn;
    cxGrdSepTableViewDTASEP: TcxGridDBColumn;
    cxGrdSepTableViewOPESEP: TcxGridDBColumn;
    btnLimpaTodos: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxGrdSepTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLimpaTodosClick(Sender: TObject);
  private
    { Private declarations }
    qrySep: TUniQuery;
  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    blnLimpaSep: Boolean;
    intSeqSep: Integer;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmSelSeparacaoParcial.btnConfirmaClick(Sender: TObject);
begin
  ModalResult := mrNone;

  If blnLimpaSep Then
    If Not fPergunta('Deseja limpar a separação selecionada?') Then
      Exit;

  inherited;
  intSeqSep := qrySep.FieldByName('SEP_SEQSEP').AsInteger;
end;

procedure TfrmSelSeparacaoParcial.btnLimpaTodosClick(Sender: TObject);
begin
  inherited;
  If Not fPergunta('Deseja limpar todas as separações do pedido?') Then
    Exit;

  intSeqSep := -1;
  ModalResult := mrOk;
end;

procedure TfrmSelSeparacaoParcial.cxGrdSepTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    pSetFocus(btnConfirma);
end;

procedure TfrmSelSeparacaoParcial.FormCreate(Sender: TObject);
begin
  inherited;
  blnLimpaSep := False;
  intSeqSep := 0;

  qrySep := fCriaQuery;

  qrySep.SQL.Add('SELECT SEP_SEQSEP,');
  qrySep.SQL.Add('       TIMESTAMP(SEP_DTASEP, SEP_HRASEP) AS SEP_DTASEP,');
  qrySep.SQL.Add('       CONCAT(SEP_OPESEP, "-", OPE_NOMOPE) AS SEP_OPESEP');
  qrySep.SQL.Add('FROM SEPPAR');
  qrySep.SQL.Add('JOIN CADOPE ON OPE_CODOPE = SEP_OPESEP');
  qrySep.SQL.Add('WHERE SEP_NUMDOC = :NUMDOC');
  qrySep.SQL.Add('  AND SEP_ESPDOC = :ESPDOC');
  qrySep.SQL.Add('  AND SEP_CODEMP = :CODEMP');
  qrySep.SQL.Add('GROUP BY SEP_SEQSEP');
  qrySep.SQL.Add('ORDER BY SEP_SEQSEP');

  dsSep.DataSet := qrySep;
end;

procedure TfrmSelSeparacaoParcial.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qrySep);
end;

procedure TfrmSelSeparacaoParcial.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Selecione a separação parcial ('+ strNumDoc +'-'+ strEspDoc +'-'+ strCodEmp +')';
  btnLimpaTodos.Visible := blnLimpaSep;

  qrySep.ParamByName('NUMDOC').AsString := strNumDoc;
  qrySep.ParamByName('ESPDOC').AsString := strEspDoc;
  qrySep.ParamByName('CODEMP').AsString := strCodEmp;
  qrySep.Open;
end;

end.
