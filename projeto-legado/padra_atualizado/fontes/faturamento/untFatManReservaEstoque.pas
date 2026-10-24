unit untFatManReservaEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, untConsertoEquipamento, Uni;

type
  TfrmFatManReservaEstoque = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    dbgGrid: TDBGridCitel;
    pnlButtons: TPanel;
    FlwPnlButtons: TFlowPanel;
    btnConfirmar: TBitBtnLocked;
    btnFechar: TBitBtnLocked;
    dtsGrid: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgGridKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    objConEqu  : TConEqu;
    blnConfirma: Boolean;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untTypesSistema, untConsultas;

procedure TfrmFatManReservaEstoque.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  objConEqu.cdsIteEqu.First;

  while not objConEqu.cdsIteEqu.Eof do
  begin
    if (fEmptyStr(objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString)) then
    begin
      pMensagemOk('Informe um lote para o item ' + objConEqu.cdsIteEqu.FieldByName('CODITE').AsString + '!');
      Exit;
    end
    else if (objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString = 'A DEFINIR')
      or (objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString = 'GARANTIA') then
    begin
      pMensagemOk('Não é permitido informar o lote ' + objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString + '!');
      Exit;
    end
    else if not fExisteLote(objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString,
                            objConEqu.cdsIteEqu.FieldByName('CODITE').AsString,
                            VS_strCodEmp,
                            True) then
    begin
      pMensagemOk('O lote informado "' + objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString + '" não existe. Verifique!');
      Exit;
    end
    else if not fLoteAprovadoLibCompra(objConEqu.cdsIteEqu.FieldByName('CODITE').AsString,
                                       objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString,
                                       VS_strCodEmp) then
    begin
      pMensagemOk('Lote "' + objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString + '" não liberado. Verifique!');
      Exit;
    end;

    objConEqu.cdsIteEqu.Next;
  end;

  blnConfirma := True;
  Close;
end;

procedure TfrmFatManReservaEstoque.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatManReservaEstoque.dbgGridKeyPress(Sender: TObject;
  var Key: Char);
var
  qryCadLot: TUniQuery;
  arrLotes: TConsultasArray;
begin
  inherited;

  Key := AnsiUpperCase(Key)[1];

  if (dbgGrid.SelectedField.FieldName = 'NUMLOT') then
  begin
    if fEntraCons(Key) then
    begin
      try
        qryCadLot := fCriaQuery;

        if fPesqLoteFat(Self, nil,
                        fCfgSis('DECUNI'),
                        objConEqu.cdsIteEqu.FieldByName('CODITE').AsString,
                        false, false,
                        qryCadLot, Key, arrLotes, '', nil, True, nil, True, True) then
        begin
          if (qryCadLot.FieldByName('LOT_NUMLOT').AsString = 'A DEFINIR')
            or (qryCadLot.FieldByName('LOT_NUMLOT').AsString = 'GARANTIA') then
          begin
            Key := #0;
            pMensagemOk('Não é permitido informar o lote ' + qryCadLot.FieldByName('LOT_NUMLOT').AsString + '!');
          end
          else if (qryCadLot.FieldByName('LOT_LOTAPR').AsString = 'N') then
          begin
            pMensagemOk('Lote "' + qryCadLot.FieldByName('NUMLOT').AsString + '" não liberado. Verifique!');
            Exit;
          end
          else
          begin
            objConEqu.cdsIteEqu.Edit;
            objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
            objConEqu.cdsIteEqu.Post;
          end;
        end;
      finally
        FreeAndNil(qryCadLot);
      end;
    end;
  end;
end;

procedure TfrmFatManReservaEstoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if blnConfirma then
    Exit;

  objConEqu.cdsIteEqu.First;

  while not objConEqu.cdsIteEqu.Eof do
  begin
    objConEqu.cdsIteEqu.Edit;
    objConEqu.cdsIteEqu.FieldByName('NUMLOT').AsString := objConEqu.cdsIteEqu.FieldByName('LOTORI').AsString;
    objConEqu.cdsIteEqu.Post;

    objConEqu.cdsIteEqu.Next;
  end;
end;

procedure TfrmFatManReservaEstoque.FormDestroy(Sender: TObject);
begin
  inherited;
  dtsGrid.DataSet := Nil;
end;

procedure TfrmFatManReservaEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (Key = VK_F10) then
    btnConfirmar.Click;
end;

procedure TfrmFatManReservaEstoque.FormShow(Sender: TObject);
begin
  inherited;

  Self.Caption := 'Definição de armazém para reserva de estoque de OS - Número ' + objConEqu.strNumero + '-' + objConEqu.strCodEmp;

  if (fCfgSis('CTLEST') = '1') then
    fFindColumnByName(dbgGrid, 'NUMLOT').Title.Caption := 'Lote';

  blnConfirma     := False;
  dtsGrid.DataSet := objConEqu.cdsIteEqu;
end;

end.
