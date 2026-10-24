unit untFatAbastecimentoDeposito;

interface

uses
 Classes, Uni, Data.DB, System.Generics.Collections,
 System.SysUtils, System.StrUtils, untFuncFatTypes,
 System.Variants, untFuncoesSimples, UniClientDataSet, untFuncoes;

type
  TInformacaoDocumentoAbastecimentoDeposito = class
    private
      FNumDoc: String;
      FEspDoc: String;
      FCodEmp: String;
      FSerie_: String;
      FTip_FC: String;
      FCodCli: String;
      FClaFis: String;
    public
      property NumDoc: String read FNumDoc write FNumDoc;
      property EspDoc: String read FEspDoc write FEspDoc;
      property CodEmp: String read FCodEmp write FCodEmp;
      property Serie_: String read FSerie_ write FSerie_;
      property Tip_FC: string read FTip_FC write FTip_FC;
      property CodCli: string read FCodCli write FCodCli;
      property ClaFis: String read FCLafis write FClafis;
  end;

  TDocumentosAbastecimentoDeposito = class
    private
      FDocAba: String;
      FEspAba: String;
      FEmpAba: String;
      FCliAba: String;
      FEhCancelamento: Boolean;
      FObjInformacaoDocumentoAbastecimentoDepositoList: TList<TInformacaoDocumentoAbastecimentoDeposito>;
    public
      constructor Create(ANumDoc, AEspDoc, ACodEmp, ACodCli: String);
      destructor Destroy; override;
      procedure pCarregaDocumentosDeAbastecimentoDeposito;

      property EhCancelamento: Boolean read FEhCancelamento write FEhCancelamento;
      property ObjInformacaoDocumentoAbastecimentoDepositoList: TList<TInformacaoDocumentoAbastecimentoDeposito> read FObjInformacaoDocumentoAbastecimentoDepositoList;
  end;



implementation



{ TDocumentosAbastecimentoDeposito }

constructor TDocumentosAbastecimentoDeposito.Create(ANumDoc, AEspDoc, ACodEmp,
  ACodCli: String);
begin
  FDocAba := ANumDoc;
  FEspAba := AEspDoc;
  FEmpAba := ACodEmp;
  FCliAba := ACodCli;
  FEhCancelamento := False;

  FObjInformacaoDocumentoAbastecimentoDepositoList := TList<TInformacaoDocumentoAbastecimentoDeposito>.Create;
end;


destructor TDocumentosAbastecimentoDeposito.Destroy;
begin
  FreeAndNil(FObjInformacaoDocumentoAbastecimentoDepositoList);
  inherited;
end;

procedure TDocumentosAbastecimentoDeposito.pCarregaDocumentosDeAbastecimentoDeposito;
var
  LQryDocumentos: TUniQuery;
  LInformacaoDocumentoAbastecimentoDeposito: TInformacaoDocumentoAbastecimentoDeposito;
begin
  LQryDocumentos := fCriaQuery;

  try
    FObjInformacaoDocumentoAbastecimentoDepositoList.Clear;

    LQryDocumentos.Close;
    LQryDocumentos.SQL.Clear;
    LQryDocumentos.SQL.Add('SELECT M.GER_NUMDOC, M.GER_ESPDOC, M.GER_CODEMP, M.GER_SERIE_, M.GER_TIP_FC, M.GER_CODCLI, M.GER_CODFOR, M.GER_CLAFIS');
    LQryDocumentos.SQL.Add('FROM MOVGER M');
    LQryDocumentos.SQL.Add('INNER JOIN AUXMOV A');
    LQryDocumentos.SQL.Add('ON(M.AUTOINCREM = A.AUX_SEQGER)');
    LQryDocumentos.SQL.Add('WHERE A.AUX_DOCABA = :DOCABA');
    LQryDocumentos.SQL.Add('AND A.AUX_ESPABA = :ESPABA');
    LQryDocumentos.SQL.Add('AND A.AUX_EMPABA = :EMPABA');
    LQryDocumentos.SQL.Add('AND A.AUX_CLIABA = :CLIABA');

    if not FEhCancelamento then
      LQryDocumentos.SQL.Add('AND M.GER_CLAFIS >= "5000"');

    LQryDocumentos.SQL.Add('ORDER BY M.GER_CLAFIS');

    LQryDocumentos.ParamByName('DOCABA').AsString := FDocAba;
    LQryDocumentos.ParamByName('ESPABA').AsString := FEspAba;
    LQryDocumentos.ParamByName('EMPABA').AsString := FEmpAba;
    LQryDocumentos.ParamByName('CLIABA').AsString := FCliAba;

    LQryDocumentos.Open;

    if LQryDocumentos.IsEmpty then
      Exit;

    while not LQryDocumentos.Eof do
    begin
      LInformacaoDocumentoAbastecimentoDeposito := TInformacaoDocumentoAbastecimentoDeposito.Create;

      LInformacaoDocumentoAbastecimentoDeposito.NumDoc := LQryDocumentos.FieldByName('GER_NUMDOC').AsString;
      LInformacaoDocumentoAbastecimentoDeposito.EspDoc := LQryDocumentos.FieldByName('GER_ESPDOC').AsString;
      LInformacaoDocumentoAbastecimentoDeposito.CodEmp := LQryDocumentos.FieldByName('GER_CODEMP').AsString;
      LInformacaoDocumentoAbastecimentoDeposito.Serie_ := LQryDocumentos.FieldByName('GER_SERIE_').AsString;
      LInformacaoDocumentoAbastecimentoDeposito.Tip_FC := LQryDocumentos.FieldByName('GER_TIP_FC').AsString;
      LInformacaoDocumentoAbastecimentoDeposito.ClaFis := LQryDocumentos.FieldByName('GER_CLAFIS').AsString;
      LInformacaoDocumentoAbastecimentoDeposito.CodCli := IIF(LInformacaoDocumentoAbastecimentoDeposito.Tip_FC = 'C', LQryDocumentos.FieldByName('GER_CODCLI').AsString, LQryDocumentos.FieldByName('GER_CODFOR').AsString);

      FObjInformacaoDocumentoAbastecimentoDepositoList.Add(LInformacaoDocumentoAbastecimentoDeposito);

      LQryDocumentos.Next;
    end;

  finally
    FreeAndNil(LQryDocumentos);
  end;
end;

end.
