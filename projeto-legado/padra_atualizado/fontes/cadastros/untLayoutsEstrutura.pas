unit untLayoutsEstrutura;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, untZClient;

  type
    TLayoutsEstrutura = Class(TObject)
    private
      FcdsLayGmt    : TZClient;
      FCodIte       : String;


    public
      property cdsLayGmt    : TZClient          read FcdsLayGmt    write FcdsLayGmt    ;
      property strCodIte    : String            read FCodIte       write FCodIte       ;

      function fEditarLayouts : boolean;
      procedure pCarregaLayGmt;
      procedure Clear;

      constructor Create;
      Destructor  Destroy; Override;
    end;


implementation

uses untFuncoesSimples, untCadLayoutsEstrutura, TypesRel;

{ TLoteIndividual }

constructor TLayoutsEstrutura.Create;
begin
  FcdsLayGmt := TZClient.Create(nil);

  FcdsLayGmt.qryQuery.SQL.Add(' SELECT SQL_NO_CACHE                                                                       ');
  FcdsLayGmt.qryQuery.SQL.Add('   LAYGMT.LAY_CODITE,                                                                      ');
  FcdsLayGmt.qryQuery.SQL.Add('   LAYGMT.LAY_ORDEM_,                                                                      ');
  FcdsLayGmt.qryQuery.SQL.Add('   LAYGMT.LAY_CODLAY,                                                                      ');
  FcdsLayGmt.qryQuery.SQL.Add('   LAYGMT.LAY_CODEMP,                                                                      ');
  FcdsLayGmt.qryQuery.SQL.Add('   LAYETI.LAY_DESCRI                                                                       ');
  FcdsLayGmt.qryQuery.SQL.Add(' FROM                                                                                      ');
  FcdsLayGmt.qryQuery.SQL.Add('   LAYGMT                                                                                  ');
  FcdsLayGmt.qryQuery.SQL.Add('    JOIN LAYETI ON  LAYETI.LAY_CODLAY = LAYGMT.LAY_CODLAY                                  ');
  FcdsLayGmt.qryQuery.SQL.Add('                AND LAYETI.LAY_CODEMP = LAYGMT.LAY_CODEMP                                  ');
  FcdsLayGmt.qryQuery.SQL.Add('                AND LAYETI.LAY_TIPLAY = '+QuotedStr(IntToStr(ARR_TIPO_LAYOUT[tpeOrdPro]))   );
  FcdsLayGmt.qryQuery.SQL.Add(' WHERE                                                                                     ');
  FcdsLayGmt.qryQuery.SQL.Add('   LAY_CODITE = :CODITE                                                                    ');
  FcdsLayGmt.qryQuery.SQL.Add(' ORDER BY                                                                                  ');
  FcdsLayGmt.qryQuery.SQL.Add('   LAY_ORDEM_                                                                              ');

  Clear;
end;

destructor TLayoutsEstrutura.Destroy;
begin
  FreeAndNil(FcdsLayGmt);
  inherited;
end;

procedure TLayoutsEstrutura.Clear;
begin
  FCodIte := '';
  If FcdsLayGmt.Active then
    FcdsLayGmt.EmptyDataSet;

  FcdsLayGmt.QryQuery.Close;
  FcdsLayGmt.Close;

end;

procedure TLayoutsEstrutura.pCarregaLayGmt;
begin
  FcdsLayGmt.QryQuery.Close;
  FcdsLayGmt.QryQuery.ParamByName('CODITE').AsString := FCodIte;
  FcdsLayGmt.fAbreClient(True, 'TfrmCadProdutos.pCarregaLayGmt');
  FcdsLayGmt.First;
End;

function TLayoutsEstrutura.fEditarLayouts : boolean;
var
  frmCadLayoutsEstrutura: TfrmCadLayoutsEstrutura;
  cdsLayGmtAux : TUniClientDataset;
begin
  result := false;
  cdsLayGmtAux := fCriaClientDatset(cdsLayGmt);
  pCriarFormularios(TfrmCadLayoutsEstrutura, frmCadLayoutsEstrutura);
  try
    cdsLayGmtAux.IndexFieldNames := 'LAY_ORDEM_';

    frmCadLayoutsEstrutura.cdsLayEst := cdsLayGmtAux;
    frmCadLayoutsEstrutura.strCodIte := FCodIte;
    frmCadLayoutsEstrutura.ShowModal;

    if frmCadLayoutsEstrutura.ModalResult = mrOk then
    begin
      cdsLayGmt.EmptyDataSet;
      cdsLayGmtAux.First;
      while not cdsLayGmtAux.eof do
      begin
        cdsLayGmt.Insert;
        cdsLayGmt.FieldByName('LAY_CODITE').AsString  := FCodIte;
        cdsLayGmt.FieldByName('LAY_CODLAY').AsString  := cdsLayGmtAux.FieldByName('LAY_CODLAY').AsString;
        cdsLayGmt.FieldByName('LAY_ORDEM_').AsInteger := cdsLayGmtAux.FieldByName('LAY_ORDEM_').AsInteger;
        cdsLayGmt.FieldByName('LAY_DESCRI').AsString  := cdsLayGmtAux.FieldByName('LAY_DESCRI').AsString;
        cdsLayGmt.FieldByName('LAY_CODEMP').AsString  := cdsLayGmtAux.FieldByName('LAY_CODEMP').AsString;
        cdsLayGmt.Post;

        cdsLayGmtAux.Next;
      end;

      result := true;
    end;

  finally
    FreeAndNil(frmCadLayoutsEstrutura);
    FreeAndNil(cdsLayGmtAux);
  end;
end;

end.
