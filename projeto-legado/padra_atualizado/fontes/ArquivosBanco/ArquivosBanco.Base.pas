unit ArquivosBanco.Base;

interface

uses
  ArquivosBanco.Interfaces, UniClientDataSet, System.Classes, Vcl.Graphics, cxGraphics;

type
  TArquivosBancoBase = class(TInterfacedObject, IArquivosBancoInterface)
  private
    FstrValorFK: String;
    FobjThumbList: TcxImageList;
  public
    function fTabela: String; virtual; abstract;
    function fPrefixo: String; virtual; abstract;
    function fCampoFK: String; virtual; abstract;
    function fTitulo: String; virtual; abstract;
    function fFileOpenFilter: String; virtual; abstract;

    function fValorFK: String; overload;
    function fValorFK(AstrValue: String): IArquivosBancoInterface; overload;

    function fThumbList: TcxImageList; overload;
    function fThumbList(AValue: TcxImageList): IArquivosBancoInterface; overload;

    procedure pCarregaArquivos(AcdsDados: TUniClientDataSet);
    procedure pGravaArquivo(AstrArquivo: String);
    procedure pExcluirArquivo(AstrAutInc: String);
  end;

implementation

uses
  ArquivosBanco.Funcoes, Uni, System.SysUtils, untFuncoesSimples, Data.DB;

{ TArquivosBancoBase }

function TArquivosBancoBase.fValorFK: String;
begin
  Result := FstrValorFK;
end;

function TArquivosBancoBase.fValorFK(
  AstrValue: String): IArquivosBancoInterface;
begin
  Result := Self;
  FstrValorFK := AstrValue;
end;

function TArquivosBancoBase.fThumbList: TcxImageList;
begin
  Result := FobjThumbList;
end;

function TArquivosBancoBase.fThumbList(AValue: TcxImageList): IArquivosBancoInterface;
begin
  Result := Self;
  FobjThumbList := AValue;
end;

procedure TArquivosBancoBase.pCarregaArquivos(AcdsDados: TUniClientDataSet);
var
  qryArquivos: TUniQuery;
  objIcone: TIcon;
  objMemoryStream: TMemoryStream;
begin
  AcdsDados.EmptyDataSet;

  qryArquivos := fCriaQuery;
  Try
    qryArquivos.SQL.Add('SELECT                            ');
    qryArquivos.SQL.Add('  AUTOINCREM,                     ');
    qryArquivos.SQL.Add('  '+ fPrefixo +'ARQB64 AS ARQB64, ');
    qryArquivos.SQL.Add('  '+ fPrefixo +'NOMARQ AS NOMARQ  ');
    qryArquivos.SQL.Add('FROM                        ');
    qryArquivos.SQL.Add('  '+ fTabela +'             ');
    qryArquivos.SQL.Add('WHERE                       ');
    qryArquivos.SQL.Add('  '+ fCampoFK +' = :CODIGO  ');
    qryArquivos.SQL.Add('ORDER BY NOMARQ             ');

    qryArquivos.ParamByName('CODIGO').AsString := fValorFK;
    qryArquivos.Open;

    while not qryArquivos.Eof do
    begin
      AcdsDados.Append;
      AcdsDados.FieldByName('AUTINC').AsString := qryArquivos.FieldByName('AUTOINCREM').AsString;
      AcdsDados.FieldByName('ARQB64').AsString := qryArquivos.FieldByName('ARQB64').AsString;
      AcdsDados.FieldByName('NOMARQ').AsString := qryArquivos.FieldByName('NOMARQ').AsString;

      objIcone := TArquivoBancoFuncoes.fGetSystemIcon(qryArquivos.FieldByName('NOMARQ').AsString);
      If Assigned(objIcone) Then
      Begin
        AcdsDados.FieldByName('IDXIMG').AsInteger := FobjThumbList.AddIcon(objIcone);
        FreeAndNil(objIcone)
      End;

      objMemoryStream := TArquivoBancoFuncoes.fBase64Decodifica(qryArquivos.FieldByName('ARQB64').AsString);
      If Assigned(objMemoryStream) Then
      Begin
        TBlobField(AcdsDados.FieldByName('ARQUIV')).LoadFromStream(objMemoryStream);
        FreeAndNil(objMemoryStream);
      End;

      AcdsDados.Post;
      qryArquivos.next;
    end;
  Finally
    FreeAndNil(qryArquivos);
  End;
end;

procedure TArquivosBancoBase.pExcluirArquivo(AstrAutInc: String);
var
  qryArquivos: TUniQuery;
begin
  qryArquivos := fCriaQuery;
  Try
    qryArquivos.SQL.Add('DELETE ');
    qryArquivos.SQL.Add('FROM ' + fTabela);
    qryArquivos.SQL.Add('WHERE AUTOINCREM = :AUTINC');
    qryArquivos.ParamByName('AUTINC').AsString := AstrAutInc;

    qryArquivos.ExecSql;
  Finally
    FreeAndNil(qryArquivos);
  End;
end;

procedure TArquivosBancoBase.pGravaArquivo(AstrArquivo: String);
var
  qryArquivos: TUniQuery;
begin
  If Not FileExists(AstrArquivo) Then
    raise Exception.CreateFmt('Arquivo não encontrado! %s', [AstrArquivo]);

  qryArquivos := fCriaQuery;
  Try
    qryArquivos.SQL.Add('SELECT *');
    qryArquivos.SQL.Add('FROM ' + fTabela);
    qryArquivos.SQL.Add('WHERE 1 <> 1');
    qryArquivos.Open;

    qryArquivos.Append;
    qryArquivos.FieldByName('AUTOINCREM').AsString       := fRetAutoIncrem(fTabela, VS_strCodEmp);
    qryArquivos.FieldByName(fPrefixo +'ARQB64').AsString := TArquivoBancoFuncoes.fBase64Codifica(AstrArquivo);
    qryArquivos.FieldByName(fPrefixo +'NOMARQ').AsString := ExtractFileName(AstrArquivo);
    qryArquivos.FieldByName(fCampoFK).AsString           := fValorFK;
    qryArquivos.Post;
  Finally
    FreeAndNil(qryArquivos);
  End;
end;

end.

