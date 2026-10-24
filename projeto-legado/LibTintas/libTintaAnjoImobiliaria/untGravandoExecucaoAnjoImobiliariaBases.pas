{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta AnjoImobiliaria *}
{**********************************************************************PH*}
unit untGravandoExecucaoAnjoImobiliariaBases;

interface

uses
  untAbstractGravandoExecucaoAnjoImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  uni, ComObj, DBFUniProvider;

type
  TGravandoExecucaoAnjoImobiliariaBases = class(TAbstractGravandoExecucaoAnjoImobiliaria)
  private
    function fRetPatDBF : String;
    function fRetPatDBF2 : String;
    procedure pGravaCadBas(strBaseSe,strProKey, strSubKey, strDesTin, strEmbalagem : String);
    procedure IsDeletaRegistro(Gravando: IGravando);

  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;const stlTabelas: TStrings): string; override;

  end;

implementation

{ TGravandoExecucaoAnjoImobiliariaBases }

uses untStrUtils;

procedure TGravandoExecucaoAnjoImobiliariaBases.Executar(const gravando: IGravando);
var
  qryDestino : IDataSet;
  qryEmbalag : IDataSet;
  qryBaseDbf : TUniQuery;
  DataBases  : TUniConnection;

  PlanilhaProd     : OleVariant;
  SheetProd        : OleVariant;
  intUltLinhaProd  : Integer;
  intLinhaProd     : Integer;

  PlanilhaSub     : OleVariant;
  SheetSub        : OleVariant;
  intUltLinhaSub  : Integer;
  intLinhaSub     : Integer;

  PlanilhaFrm     : OleVariant;
  SheetFrm        : OleVariant;
  intUltLinhaFrm  : Integer;
  intLinhaProgFrm : Integer;
  intLinhaFrm     : Integer;

  strPatPro : String;
  strProKey : String;

  strPatSub : String;
  strSubKey : String;

  strBaseSe : String;
  strDesTin : String;

  intPatAnjo : Integer;
  strPath    : String;
  strSQLBase: String;
begin
  Try
    Try

      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not DirectoryExists(fRetPatDBF)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      IsDeletaRegistro(Gravando);



      strPath := fRetPatDBF;

      For intPatAnjo := 1 to 2 do
      Begin
        If intPatAnjo = 2 Then
        Begin
          if ((strPath = EmptyStr) Or (fRetPatDBF2 = EmptyStr)) then
            Exit
          else
            strPath := fRetPatDBF2;
        End;


        PlanilhaProd := CreateOleObject('Excel.Application');
        PlanilhaProd.WorkBooks.open(strPath + '\PRODUCTS.DBF');

        DataBases := TUniConnection.Create(Nil);
        DataBases.ProviderName := 'DBF';
        DataBases.LoginPrompt  := False;

        DataBases.Database     := strPath;

        If (Not DataBases.Connected) Then
          DataBases.Connected := True;

        qryBaseDbf := TUniQuery.Create(Nil);
        qryBaseDbf.Connection := DataBases;

        qryBaseDbf.Close;
        qryBaseDbf.SQL.Clear;
        qryBaseDbf.SQL.Add(' SELECT * FROM \BASES.DBF');
        qryBaseDbf.Open;

        strSQLBase := qryBaseDbf.SQL.Text;

        gravando.Texto := 'Dados carregados com sucesso!';

        gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('ANJ_CADBAS');
        gravando.Texto := 'PROCOD verificado com sucesso!';

        SheetProd := PlanilhaProd.Workbooks[1].WorkSheets['PRODUCTS'];

        intUltLinhaProd := SheetProd.Cells.SpecialCells(11).Row;

        intLinhaProd     := 2;

        qryEmbalag     := TAutcomTintaFactory.Get.fGetDataSet;
        qryEmbalag.SQL := 'SELECT * '+
                          '  FROM ANJ_CADEMB '+
                          ' WHERE EMB_USAEMB = "S"';

        While (intLinhaProd <= intUltLinhaProd) Do
        begin
          Try
            Try
              if gravando.Status <> sgGravando then
                Exit;

              strPatPro := strPath + '\' + SheetProd.cells[intLinhaProd, 4].Text;
              strProKey := TStrUtils.fStrZero(Trim(SheetProd.cells[intLinhaProd, 1].Text),2);

              PlanilhaSub := CreateOleObject('Excel.Application');
              PlanilhaSub.WorkBooks.open(strPatPro + '\SUBPRODS.DBF');

              SheetSub := PlanilhaSub.Workbooks[1].WorkSheets['SUBPRODS'];

              intUltLinhaSub := SheetSub.Cells.SpecialCells(11).Row;

              intLinhaSub     := 2;

              Try
                While (intLinhaSub <= intUltLinhaSub) Do
                begin
                  strPatSub := strPatPro + '\' + SheetSub.cells[intLinhaSub, 4].Text;
                  strSubKey := TStrUtils.fStrZero(Trim(SheetSub.cells[intLinhaSub, 1].Text), 2);

                  PlanilhaFrm := CreateOleObject('Excel.Application');

                  If FileExists(strPatSub + '\FRM.DBF') Then
                    PlanilhaFrm.WorkBooks.open(strPatSub + '\FRM.DBF')
                  Else If FileExists(strPatPro + '\frm.dbf') Then
                    PlanilhaFrm.WorkBooks.open(strPatPro + '\FRM.DBF')
                  Else
                    PlanilhaFrm.WorkBooks.open(strPath + '\FRM.DBF');


                  SheetFrm := PlanilhaFrm.Workbooks[1].WorkSheets['FRM'];

                  intUltLinhaFrm := SheetFrm.Cells.SpecialCells(11).Row;

                  gravando.Texto := 'Carregando os registros do arquivo ' + strPatPro + '\FRM.DBF';

                  intLinhaFrm     := 2;
                  intLinhaProgFrm := 1;

                  Try
                    While (intLinhaFrm <= intUltLinhaFrm) Do
                    Begin
                      qryEmbalag.Close;
                      qryEmbalag.Open;
                      qryEmbalag.First;

                      While Not(qryEmbalag.Eof) Do
                      Begin
                        strBaseSe := TStrUtils.fStrZero(Trim(SheetFrm.cells[intLinhaFrm, 7].Text), 2);

                        qryBaseDbf.Close;
                        qryBaseDbf.SQL.Clear;
                        qryBaseDbf.SQL.Text := strSQLBase + ' WHERE TRIM(ID) = :BASE_ID   ';
                        qryBaseDbf.ParamByName('BASE_ID').AsString := SheetFrm.cells[intLinhaFrm, 7].Text;
                        qryBaseDbf.Open;

                        //qryBaseDbf.Locate('ID', SheetFrm.cells[intLinhaFrm, 7].Text, []);

                        strDesTin := AnsiUpperCase( Trim(SheetProd.cells[intLinhaProd, 3].Text) + ' ' +
                                                    Trim(SheetSub.cells[intLinhaSub, 3].Text) + ' ' +
                                                    Trim(qryBaseDbf.FieldByName('DESCR').AsString) + ' ' +
                                                    FormatFloat('0.00', qryEmbalag.FieldByName('EMB_QTDEMB').AsFloat / 1000) + 'L'
                                                  );
                        pGravaCadBas(strBaseSe, strProKey, strSubKey, strDesTin, qryEmbalag.FieldByName('EMB_UNIDAD').AsString);

                        qryEmbalag.Next;
                      End;

                      gravando.RegistrarProgresso(0, intLinhaProgFrm, intUltLinhaFrm);

                      Inc(intLinhaFrm);
                      Inc(intLinhaProgFrm);

                    End;
                  Finally
                    gravando.RegistrarProgresso(0, intLinhaProgFrm, intUltLinhaFrm);
                    PlanilhaFrm.WorkBooks.Close;
                  End;

                  Inc(intLinhaSub);

                End;
              Finally
                PlanilhaSub.WorkBooks.Close;
              End;

              Inc(intLinhaProd);

            Except
              on E: Exception do
              begin
                gravando.Cancelar;
                gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
              end;
            End;
          Finally
           // gravando.RegistrarProgresso(0, intLinhaProgProd, intUltLinhaProd);
          End;
        end;
      End;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    PlanilhaProd.WorkBooks.Close;
  End;
end;

function TGravandoExecucaoAnjoImobiliariaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoAnjoImobiliariaBases.fRetPatDBF: String;
begin
  Result := conf.fGet('PATANJ'); //ANJO1
end;

function TGravandoExecucaoAnjoImobiliariaBases.fRetPatDBF2: String;
begin
  Result := conf.fGet('ANJPAT');
end;


function TGravandoExecucaoAnjoImobiliariaBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ANJ_CADBAS';
end;

function TGravandoExecucaoAnjoImobiliariaBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoAnjoImobiliariaBases.IsDeletaRegistro(
  Gravando: IGravando);
Var
  qryGen: IDataSet;
begin
  Gravando.Texto := 'Deletando registros da tabela ANJ_CADBAS...';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   DELETE FROM ANJ_CADBAS    ';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoAnjoImobiliariaBases.pGravaCadBas(strBaseSe,strProKey, strSubKey, strDesTin, strEmbalagem : String);
Var
  qryCadBas  : IDataSet;
begin
  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;

  qryCadBas.SQL := 'SELECT * '+
                   '  FROM ANJ_CADBAS ';
  qryCadBas.open;

  If Not qryCadBas.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD',
                   VarArrayOf([strBaseSe, strProKey, strSubKey, strEmbalagem]), []) Then
  Begin
    qryCadBas.Insert;
    qryCadBas.FieldByName('BAS_BASE__').AsString := strBaseSe;
    qryCadBas.FieldByName('BAS_PROKEY').AsString := strProKey;
    qryCadBas.FieldByName('BAS_SUBKEY').AsString := strSubKey;
    qryCadBas.FieldByName('BAS_UNIDAD').AsString := strEmbalagem;
    qryCadBas.FieldByName('BAS_DESCRI').AsString := strDesTin;
    qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ANJ_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryCadBas.Post;
  End;
end;

end.
