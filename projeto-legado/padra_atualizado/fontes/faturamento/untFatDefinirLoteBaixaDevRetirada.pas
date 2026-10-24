unit untFatDefinirLoteBaixaDevRetirada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Uni, UniClientDataSet,
  untFuncFat;

type
  TfrmFatDefinirLoteBaixaDevRetirada = class(TfrmPaiConfirma)
    dtsGrid: TDataSource;
    dbgGrid: TDBGridCitel;
    procedure FormShow(Sender: TObject);
    procedure dbgGridKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    blnConfirma: Boolean;

    procedure pCarregaSugestaoLote;
    function fUsaSugestaoLoteMenorValidade: Boolean;
  public
    { Public declarations }
    cdsVenda: TUniClientDataSet;
    fatVenda: TFatVenda;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmFatDefinirLoteBaixaDevRetirada.btnConfirmaClick(Sender: TObject);
begin
  ModalResult := mrNone;
  cdsVenda.First;

  while not cdsVenda.Eof do
  begin
    if (fEmptyStr(cdsVenda.FieldByName('ITE_NUMLOT').AsString)) then
    begin
      pMensagemOk('Informe um lote para o item ' + cdsVenda.FieldByName('ITE_CODITE').AsString + '!');
      Exit;
    end
    else if (cdsVenda.FieldByName('ITE_NUMLOT').AsString = 'A DEFINIR')
      or (cdsVenda.FieldByName('ITE_NUMLOT').AsString = 'GARANTIA') then
    begin
      pMensagemOk('Não é permitido informar o lote ' + cdsVenda.FieldByName('ITE_NUMLOT').AsString + '!');
      Exit;
    end
    else if not fExisteLote(cdsVenda.FieldByName('ITE_NUMLOT').AsString,
                            cdsVenda.FieldByName('ITE_CODITE').AsString,
                            VS_strCodEmp,
                            True) then
    begin
      pMensagemOk('O lote informado "' + cdsVenda.FieldByName('ITE_NUMLOT').AsString + '" não existe. Verifique!');
      Exit;
    end
    else if not fLoteAprovadoLibCompra(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                       cdsVenda.FieldByName('ITE_NUMLOT').AsString,
                                       VS_strCodEmp) then
    begin
      pMensagemOk('Lote "' + cdsVenda.FieldByName('ITE_NUMLOT').AsString + '" não liberado. Verifique!');
      Exit;
    end;

    cdsVenda.Next;
  end;

  blnConfirma := True;
  inherited;
end;

procedure TfrmFatDefinirLoteBaixaDevRetirada.dbgGridKeyPress(Sender: TObject;
  var Key: Char);
var
  qryCadLot: TUniQuery;
  arrLotes: TConsultasArray;
begin
  inherited;

  Key := AnsiUpperCase(Key)[1];

  if (dbgGrid.SelectedField.FieldName = 'ITE_NUMLOT') then
  begin
    if fEntraCons(Key) then
    begin
      try
        qryCadLot := fCriaQuery;

        if fPesqLoteFat(Self, nil,
                        fCfgSis('DECUNI'),
                        cdsVenda.FieldByName('ITE_CODITE').AsString,
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
            pMensagemOk('Lote "' + qryCadLot.FieldByName('ITE_NUMLOT').AsString + '" não liberado. Verifique!');
            Exit;
          end
          else
          begin
            cdsVenda.Edit;
            cdsVenda.FieldByName('ITE_NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
            cdsVenda.Post;
          end;
        end;
      finally
        FreeAndNil(qryCadLot);
      end;
    end;
  end;
end;

procedure TfrmFatDefinirLoteBaixaDevRetirada.FormCreate(Sender: TObject);
begin
  inherited;

  cdsVenda := nil;
  fatVenda := nil;
end;

procedure TfrmFatDefinirLoteBaixaDevRetirada.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Definir ' + IIF((fCfgSis('CTLEST') = '1'), 'Lote', 'Armazém');

  if (fCfgSis('CTLEST') = '1') then
    fFindColumnByName(dbgGrid, 'ITE_NUMLOT').Title.Caption := 'Lote';

  pCarregaSugestaoLote;
  dtsGrid.DataSet := cdsVenda;
end;

function TfrmFatDefinirLoteBaixaDevRetirada.fUsaSugestaoLoteMenorValidade: Boolean;
begin
  if fCfgSis('NOMEMP') = '2' then
    Result := not fEmptyStr(fRetFantasiaEmpresa(IIF(fatVenda.blnEmpFat, cdsVenda.FieldByName('ITE_EMPITE').AsString, fatVenda.fEmpresaSaldoMatriz_CD)))
  else
    Result := not fEmptyStr(fRetNomeEmpresaSelec(IIF(fatVenda.blnEmpFat, cdsVenda.FieldByName('ITE_EMPITE').AsString, fatVenda.fEmpresaSaldoMatriz_CD)));
end;

procedure TfrmFatDefinirLoteBaixaDevRetirada.pCarregaSugestaoLote;
var
  strLoteMenorValidade: String;
begin
  cdsVenda.First;

  while not cdsVenda.Eof do
  begin
    if (not fEmptyStr(cdsVenda.FieldByName('ITE_NUMLOT').AsString)) then
    begin
      cdsVenda.Next;
      Continue;
    end;

    if (fUsaSugestaoLoteMenorValidade) then
    begin
      strLoteMenorValidade := fatVenda.objCadLot.fRetLoteMenorValidade(cdsVenda.FieldByName('ITE_CODITE').AsString, cdsVenda.FieldByName('ITE_EMPITE').AsString, nil);

      cdsVenda.Edit;
      cdsVenda.FieldByName('ITE_NUMLOT').AsString := strLoteMenorValidade;
      cdsVenda.Post;
    end;

    if (not fUsaSugestaoLoteMenorValidade) and (fCfgSis('FTLTPR', varBoolean)) and (fEmptyStr(cdsVenda.FieldByName('ITE_NUMLOT').AsString)) then
    begin
      cdsVenda.Edit;
      cdsVenda.FieldByName('ITE_NUMLOT').AsString := fatVenda.objCadLot.fRetArmazemPrincipalOrcamentoPedidoVenda(cdsVenda.FieldByName('ITE_CODITE').AsString);
      cdsVenda.Post;
    end;

    cdsVenda.Next;
  end;

  cdsVenda.First;
end;

end.
