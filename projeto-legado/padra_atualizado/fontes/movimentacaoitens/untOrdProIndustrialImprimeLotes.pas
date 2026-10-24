unit untOrdProIndustrialImprimeLotes;

interface

uses
  System.SysUtils, System.Classes, untZClient, untOrdProIndustrial, frxClass,
  frxDBSet, Uni, Forms, Data.DB;

type
  TfrmOrdProIndustrialImprimeLotes = class(Tform)
    frxReport: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
  private
    cdsRelatorio : TZClient;
    function fGetSQL : String;
  public
    procedure pAddItens(arrLotes : Array Of TRecReservaEstoque; strCodPag : String);
    procedure pExibeRelatorio;
  end;

var
  frmOrdProIndustrialImprimeLotes: TfrmOrdProIndustrialImprimeLotes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmOrdProIndustrialImprimeLotes.DataModuleCreate(Sender: TObject);
begin
  cdsRelatorio := TZClient.Create(Self, fGetSQL);
  With cdsRelatorio.qryQuery.SQL Do
    Add(' WHERE FALSE ');
  cdsRelatorio.fAbreClient(True, 'TfrmOrdProIndustrialImprimeLotes.DataModuleCreate');

end;

function TfrmOrdProIndustrialImprimeLotes.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT ITE_CODITE AS CODPAG,                 '; // Codigo do prod. granel (quebra do relatorio);
  Result := Result + '        ITE_DESITE AS DESPAG,                 ';
  Result := Result + '        ITE_CODITE AS CODITE,                 ';
  Result := Result + '        ITE_DESITE AS DESITE,                 ';
  Result := Result + '        ITE_REFERE AS REFERE,                 ';
  Result := Result + '        UNI_SIGUNI AS SIGUNI,                 ';
  Result := Result + '        LOT_NUMLOT AS NUMLOT,                 ';
  Result := Result + '        000000.000 AS QTDNES,                 ';
  Result := Result + '        000000.000 AS QTDUTI,                 ';
  Result := Result + '        LOT_SALDOS AS SALDOS                  ';
  Result := Result + ' FROM CADLOT                                  ';
  Result := Result + ' INNER JOIN CADITE ON ITE_CODITE = LOT_CODITE ';
  Result := Result + ' LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
end;

procedure TfrmOrdProIndustrialImprimeLotes.pAddItens(arrLotes: array of TRecReservaEstoque; strCodPag: String);
  Var
    intIndex : Integer;
    qryCadIte: TUniQuery;
begin
  Try
    qryCadIte := fCriaQuery;
    With qryCadIte, SQL Do
    Begin
      Close;
      Clear;
      Add( fGetSQL );
      Add( ' WHERE LOT_CODITE = :CODITE ');
      Add( '   AND LOT_CODEMP = :CODEMP ');
      Add( '   AND LOT_NUMLOT = :NUMLOT');

      For intIndex := 0 To Length(arrLotes) -1  Do
      Begin
        Close;
        ParamByName('CODITE').AsString := arrLotes[intIndex].strCodIte;
        ParamByName('NUMLOT').AsString := arrLotes[intIndex].strNumLot;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        cdsRelatorio.Append;
        cdsRelatorio.FieldByName('CODPAG').AsString := strCodPag;
        cdsRelatorio.FieldByName('DESPAG').AsString := fRetNomProduto(strCodPag);
        cdsRelatorio.FieldByName('CODITE').AsString := arrLotes[intIndex].strCodIte;
        cdsRelatorio.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
        cdsRelatorio.FieldByName('REFERE').AsString := FieldByName('REFERE').AsString;
        cdsRelatorio.FieldByName('SIGUNI').AsString := FieldByName('SIGUNI').AsString;
        cdsRelatorio.FieldByName('NUMLOT').AsString := arrLotes[intIndex].strNumLot;
        cdsRelatorio.FieldByName('QTDUTI').AsFloat  := arrLotes[intIndex].fltQtdIte;
        cdsRelatorio.FieldByName('QTDNES').AsFloat  := arrLotes[intIndex].fltQtdTot;
        cdsRelatorio.FieldByName('SALDOS').AsFloat  := fRetornaSaldoDisponivel(arrLotes[intIndex].strCodIte, False, True,
                                                                               arrLotes[intIndex].strNumLot);
        cdsRelatorio.Post;
      end;

    End;

  Finally
    FreeAndNil(qryCadIte);
  End;

end;

procedure TfrmOrdProIndustrialImprimeLotes.pExibeRelatorio;
begin
  If (Not cdsRelatorio.Active) Or cdsRelatorio.IsEmpty Then
    Exit;

  frxRelatorio.DataSource := cdsRelatorio.dtsSource;
  pPreviewReport(Self.Name, 'Ordem de Produção Industrial (Lotes)', frxReport);
end;

end.

