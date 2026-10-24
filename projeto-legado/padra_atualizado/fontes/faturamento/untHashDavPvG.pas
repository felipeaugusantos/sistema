unit untHashDavPvG;

interface

uses SysUtils, DB, Classes;

Type
  THashDavPvG = class(TObject)
    private
      FCampos: TStringList;
      procedure pCarregarCampos;
    public
      constructor Create;
      function fRetornaMD5Query(qryTabela: TDataSet): String;
      function fRetornaSQLMD5: String;

      destructor Destroy; override;
  End;

Type
  THashDavPvD = class(TObject)
    private
      FCampos: TStringList;
      procedure pCarregarCampos;
    public
      constructor Create;
      function fRetornaMD5Query(qryTabela: TDataSet): String;
      function fRetornaSQLMD5: String;

      destructor Destroy; override;
  End;

implementation

uses
  untHashTabelas;

{ THashDavPvG }

constructor THashDavPvG.Create;
begin
  FCampos := TStringList.Create;
  pCarregarCampos;
end;

procedure THashDavPvG.pCarregarCampos;
begin
  FCampos.Add('AUTOINCREM');
  FCampos.Add('DPG_NDAVPV');
  FCampos.Add('DPG_NUMDOC');
  FCampos.Add('DPG_ESPDOC');
  FCampos.Add('DPG_CODEMP');
  FCampos.Add('DPG_CODCLI');
  FCampos.Add('DPG_DTAENT');
  FCampos.Add('DPG_CGCCON');
  FCampos.Add('DPG_NOMCON');
  FCampos.Add('DPG_ENDCON');
  FCampos.Add('DPG_BAICON');
  FCampos.Add('DPG_CIDCON');
  FCampos.Add('DPG_ESTADO');
  FCampos.Add('DPG_TELCON');
  FCampos.Add('DPG_JAFATU');
  FCampos.Add('DPG_CODFPG');
  FCampos.Add('DPG_CODCND');
  FCampos.Add('DPG_CODPOR');
  FCampos.Add('DPG_TOTPRO');
  FCampos.Add('DPG_DESESP');
  FCampos.Add('DPG_TOTRET');
  FCampos.Add('DPG_TOTSER');
  FCampos.Add('DPG_TOTFRE');
  FCampos.Add('DPG_TOTIPI');
  FCampos.Add('DPG_VLRCON');
  FCampos.Add('DPG_COODAV');
  FCampos.Add('DPG_NUMSER');
  FCampos.Add('DPG_MFADIC');
  FCampos.Add('DPG_TIPECF');
  FCampos.Add('DPG_MARECF');
  FCampos.Add('DPG_MODECF');
  FCampos.Add('DPG_COO_CF');
  FCampos.Add('DPG_SER_CF');
  FCampos.Add('DPG_NUMCAI');
  FCampos.Add('DPG_TOTDUP');
  FCampos.Add('DPG_VPAR01');
  FCampos.Add('DPG_VPAR02');
  FCampos.Add('DPG_VPAR03');
  FCampos.Add('DPG_VPAR04');
  FCampos.Add('DPG_VPAR05');
  FCampos.Add('DPG_VPAR06');
  FCampos.Add('DPG_VPAR07');
  FCampos.Add('DPG_VPAR08');
  FCampos.Add('DPG_VPAR09');
  FCampos.Add('DPG_VPAR10');
  FCampos.Add('DPG_VPAR11');
  FCampos.Add('DPG_VPAR12');
end;

function THashDavPvG.fRetornaMD5Query(qryTabela: TDataSet): String;
begin
  Result := fCacheHash.fCriarOuRetornarHashTabela('DAVPVG', FCampos).
    fRetornaMd5Query(qryTabela);
end;

function THashDavPvG.fRetornaSQLMD5: String;
begin
  Result := fCacheHash.fCriarOuRetornarHashTabela('DAVPVG', FCampos).
    fRetornaSQLMD5;
end;

destructor THashDavPvG.Destroy;
begin
  FreeAndNil(FCampos);
  inherited;
end;

{ THashDavPvD }

constructor THashDavPvD.Create;
begin
  FCampos := TStringList.Create;
  pCarregarCampos;
end;

destructor THashDavPvD.Destroy;
begin
  FreeAndNil(FCampos);
  inherited;
end;

function THashDavPvD.fRetornaMD5Query(qryTabela: TDataSet): String;
begin
  Result := fCacheHash.fCriarOuRetornarHashTabela('DAVPVD', FCampos).
    fRetornaMd5Query(qryTabela);
end;

function THashDavPvD.fRetornaSQLMD5: String;
begin
  Result := fCacheHash.fCriarOuRetornarHashTabela('DAVPVD', FCampos).
    fRetornaSQLMD5;
end;

procedure THashDavPvD.pCarregarCampos;
begin
  FCampos.Add('AUTOINCREM');
  FCampos.Add('DPD_SEQGER');
  FCampos.Add('DPD_CODITE');
  FCampos.Add('DPD_DESCRI');
  FCampos.Add('DPD_QTDITE');
  FCampos.Add('DPD_UNITAR');
  FCampos.Add('DPD_TOTITE');
  FCampos.Add('DPD_DESESP');
  FCampos.Add('DPD_CODUNI');
  FCampos.Add('DPD_CANCEL');
  FCampos.Add('DPD_CODFIS');
  FCampos.Add('DPD_DTAENT');
  FCampos.Add('DPD_ALQICM');
  FCampos.Add('DPD_CODACA');
  FCampos.Add('DPD_EMPACA');
  FCampos.Add('DPD_ITEEMB');
  FCampos.Add('DPD_NUMLOT');
end;

end.
